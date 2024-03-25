import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myth_maker/consts.dart';
import 'package:myth_maker/widgets/shimmer.dart';

class pfp extends StatelessWidget {
  pfp({
    super.key,
    required this.userName,
    required this.pfpLink,
  });

  String userName;

  String pfpLink;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: CachedNetworkImage(
          imageUrl: pfpLink,
          width: 50.w,
          height: 50.h,
          maxHeightDiskCache: 100,
          maxWidthDiskCache: 100,
          placeholder: (context, url) => shimmerContainer(
            width: 50.w,
            height: 50.h,
          ),
          errorWidget: (context, url, error) {
            return Container(
              width: 50.w,
              height: 50.h,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(1000.h),
              ),
              child: Center(
                child: Text(
                  getFirstLetters(userName),
                  style: TextStyle(
                    color: white,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String getFirstLetters(String text) {
    List<String> words = text.split(' ');

    String firstLetters =
        words.map((word) => word.isNotEmpty ? word[0] : '').join();

    return firstLetters;
  }
}
