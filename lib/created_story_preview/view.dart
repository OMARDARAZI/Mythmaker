import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../consts.dart';
import 'logic.dart';

class CreatedStoryPreviewPage extends StatelessWidget {
  CreatedStoryPreviewPage({
    Key? key,
    required this.story,
    required this.title,
  }) : super(key: key);

  String story;
  String title;
  final logic = Get.put(CreatedStoryPreviewLogic());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Iconsax.arrow_left_2,
              color: Colors.black,
              size: 35.sp,
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25.sp,
              color: black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
              ),
              SizedBox(
                height: 30.h,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  width: 470.w,
                  height: 290.h,
                  imageUrl: "",
                  placeholder: (context, url) =>
                      Center(child: Image.asset('assets/images/no image.png')),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              SizedBox(
                height: 35.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  story,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                  ),
                  softWrap: true,
                  textDirection: logic.isMostlyArabic(story)
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                ),
              ),
              SizedBox(height: 60.h,),
              GestureDetector(
                onTap: () {

                },
                child: AnimatedContainer(
                  width: 350.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  duration: const Duration(milliseconds: 200),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Iconsax.edit,color: Colors.white,),
                      SizedBox(width: 10,),
                      Text(
                        'Edit Story',
                        style: TextStyle(
                          fontSize: 22.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30.h,),
              InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {

                },
                child: AnimatedContainer(
                  width: 350.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: primaryColor),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  duration: const Duration(milliseconds: 200),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.share_outlined,color: Colors.black,),
                      SizedBox(width: 10,),
                      Text(
                        'Share Story',
                        style: TextStyle(
                          fontSize: 22.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30.h,),
            ],
          ),
        ),
      ),
    );
  }
}
