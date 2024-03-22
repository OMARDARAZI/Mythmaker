import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:myth_maker/consts.dart';
import 'package:typewritertext/typewritertext.dart';

import 'logic.dart';

class GeneratingStoryPage extends StatefulWidget {
  GeneratingStoryPage({
    Key? key,
    required this.title,
    required this.genre,
    required this.description,
  }) : super(key: key);

  String title;
  String description;
  String genre;

  @override
  State<GeneratingStoryPage> createState() => _GeneratingStoryPageState();
}

class _GeneratingStoryPageState extends State<GeneratingStoryPage> {
  final logic = Get.put(GeneratingStoryLogic());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    logic.generateStory(
        title: widget.title, desc: widget.description, genre: widget.genre, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/lottie/book.json',
                height: 300.h, frameRate: FrameRate(60)),
            Text(
              'Generating Story',
              style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15.sp,
            ),
            TypeWriter(
              controller: logic.valueController,
              builder: (context, value) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    value.text,
                    style: TextStyle(color: Colors.grey, fontSize: 15.sp),
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
