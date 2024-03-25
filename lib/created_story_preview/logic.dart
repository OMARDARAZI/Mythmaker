import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:myth_maker/consts.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:typewritertext/typewritertext.dart';

class CreatedStoryPreviewLogic extends GetxController {
  bool isMostlyArabic(String input) {
    int arabicCount = 0;
    int englishCount = 0;

    input.runes.forEach((int rune) {
      var character = String.fromCharCode(rune);
      if (character.contains(RegExp(r'[\u0600-\u06FF]'))) {
        arabicCount++;
      } else if (character.contains(RegExp(r'[a-zA-Z]'))) {
        englishCount++;
      }
    });

    return arabicCount > englishCount;
  }

  Future<void> addPost({
    required String title,
    required String story,
    required String image,
    required List<String> likes,
    required List<Map<String, dynamic>> comments,
    required String postedById,
  }) async {
    final url = Uri.parse('$backendLink/addPost');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'title': title,
        'story': story,
        'image': image,
        'likes': likes,
        'comments': comments,
        'postedBy': postedById,
      }),
    );
    if (response.statusCode == 201) {
      print("Post added successfully.");
      final responseData = json.decode(response.body);
      print(responseData);
    } else {
      print("Failed to add post. Status code: ${response.statusCode}");
      print("Error: ${response.body}");
    }
  }

  void showShareBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      // Make background transparent to customize shape
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    right: 8.0, left: 8, top: 10, bottom: 2),
                child: ListTile(
                  leading: SvgPicture.asset(
                    'assets/svg/upload.svg',
                    color: Colors.black,
                  ),
                  title: Text('Upload'),
                  onTap: () {
                    Get.back();
                    showUploading(context, '');
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    right: 8.0, left: 8, top: 2, bottom: 15),
                child: ListTile(
                  leading: SvgPicture.asset(
                    'assets/svg/share.svg',
                    color: Colors.black,
                  ),
                  title: Text('Share To Friends'),
                  onTap: () {},
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  showUploading(BuildContext context, String image) {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            width: 300.w,
            height: 350.h,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        width: 190.w,
                        height: 200.h,
                        imageUrl: image,
                        placeholder: (context, url) => Center(
                            child: Image.asset('assets/images/no image.png')),
                        errorWidget: (context, url, error) =>
                            Image.asset('assets/images/no image.png'),
                      ),
                    ),
                    Positioned(
                        right: 25,
                        left: 25,
                        top: 25,
                        bottom: 25,
                        child: Center(child: CircularProgressIndicator()))
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Uploading',
                      style: TextStyle(
                          fontSize: 16.sp,
                          decoration: TextDecoration.none,
                          color: Colors.black),
                    ),
                    TypeWriterText(
                      text: Text('...'),
                      play: true,
                      repeat: true,
                      duration: Duration(milliseconds: 100),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
