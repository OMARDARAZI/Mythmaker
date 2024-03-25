import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:myth_maker/consts.dart';
import 'package:myth_maker/widgets/pfp.dart';
import 'package:myth_maker/widgets/shimmer.dart';

class storyCard extends StatelessWidget {
  storyCard({
    super.key,
    required this.story,
    required this.title,
    required this.comments,
    required this.likes,
    required this.username,
    required this.image,
    required this.pfpLink,
    required this.date,
  });

  DateTime date;
  String image;
  String title;
  String story;
  int likes;
  int comments;
  String username;
  String pfpLink;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: pfpLink,
                  width: 50.w,height: 50.h,
                  errorWidget: (context, url, error) {
                    return Container(
                      width: 50.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(1000.h)),
                      child: Center(
                        child: Text(
                          getFirstLetters(username),
                          style: TextStyle(
                            color: white,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text('${username}'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: 300,
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CachedNetworkImage(
                      imageUrl: image,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => shimmerContainer(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                )),
          ),
          SizedBox(
            height: 30.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20.sp,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                Container(
                  width: 300.w,
                  child: Text(
                    '${story.length > 100 ? story.substring(0, 100) + '...' : story}',
                    style: TextStyle(fontSize: 17.sp, color: Colors.grey),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 25.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                Icon(
                  Iconsax.like,
                  color: Colors.grey,
                  size: 20.sp,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  '$likes Likes',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                Icon(
                  Iconsax.message,
                  size: 20.sp,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  '$comments Comments',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                Text(
                  '${calculateTimeAgo(date)}',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  String calculateTimeAgo(DateTime dateTime) {
    final DateTime now = DateTime.now();
    final Duration difference = now.difference(dateTime);

    if (difference.inDays >= 7) {
      return DateFormat('MMMM d, y').format(dateTime);
    } else if (difference.inDays >= 1) {
      return difference.inDays == 1
          ? '1 day ago'
          : '${difference.inDays} days ago';
    } else if (difference.inHours >= 1) {
      return difference.inHours == 1
          ? '1 hour ago'
          : '${difference.inHours} hours ago';
    } else if (difference.inMinutes >= 1) {
      return difference.inMinutes == 1
          ? '1 minute ago'
          : '${difference.inMinutes} minutes ago';
    } else {
      return difference.inSeconds == 1
          ? '1 second ago'
          : '${difference.inSeconds} seconds ago';
    }
  }


  String getFirstLetters(String text) {
    List<String> words = text.split(' ');

    String firstLetters =
    words.map((word) => word.isNotEmpty ? word[0] : '').join();

    return firstLetters;
  }
}
