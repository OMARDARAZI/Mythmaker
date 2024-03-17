import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:myth_maker/consts.dart';
import 'package:myth_maker/created_story_preview/view.dart';
import 'package:myth_maker/generating_story/view.dart';
import 'package:myth_maker/widgets/TextField.dart';
import 'package:myth_maker/widgets/primaryBtn.dart';

import 'logic.dart';

class StoryDataPage extends StatelessWidget {
  StoryDataPage({Key? key}) : super(key: key);

  final logic = Get.put(StoryDataLogic());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<StoryDataLogic>(
        init: StoryDataLogic(),
        builder: (logic) {
          return Scaffold(
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
                'Create a story',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.sp,
                  color: black,
                ),
              ),
            ),
            backgroundColor: backgroundColor,
            body: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Form(
                key: logic.formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 50.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        children: [
                          Text(
                            'Title',
                            style: TextStyle(
                              fontSize: 25.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    customeTextField(
                      hint: 'Story Title',
                      controller: logic.titleController,
                      onChanged: (p0) {
                        logic.update();
                      },
                      validator: (p0) {
                        if (p0!.length == 0) {
                          return 'Enter Story Title';
                        }
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        children: [
                          Text(
                            'Genre',
                            style: TextStyle(
                              fontSize: 25.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 380.w,
                          height: 70.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.sp),
                          ),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              canvasColor: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: logic.selectedGenre,
                                  hint: const Text('Select Genre'),
                                  icon: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Icon(
                                      Iconsax.arrow_down_1,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  items: logic.genres
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    logic.selectGenre(newValue!);
                                  },
                                  style: const TextStyle(color: Colors.black),
                                  iconEnabledColor: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    logic.showGenreError
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 350.w,
                              child: const Row(
                                children: [
                                  Text(
                                    'Select a Genre',
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(),
                    SizedBox(
                      height: 25.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        children: [
                          Text(
                            'Story Description',
                            style: TextStyle(
                              fontSize: 20.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.sizeOf(context).width,
                          child: customeTextField(
                            validator: (p0) {
                              if (p0!.length == 0) {
                                return 'Enter Story Idea';
                              }
                            },
                            maxLines: 8,
                            hint: 'Story Idea',
                            controller: logic.descriptionController,
                            onChanged: (p0) {
                              logic.update();
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 60.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (logic.formKey.currentState!.validate() &&
                            logic.selectedGenre != null) {
                          Get.to(
                            () => GeneratingStoryPage(
                              description:
                                  logic.descriptionController.text.trim(),
                              title: logic.titleController.text.trim(),
                              genre: logic.selectedGenre.toString(),
                            ),
                          );
                        }

                        if (logic.selectedGenre == null) {
                          logic.showGenreErr();
                        } else {
                          logic.hideGenreErr();
                        }

                        logic.update();
                      },
                      child: AnimatedContainer(
                        width: 350.w,
                        height: 70.h,
                        decoration: BoxDecoration(
                          color: logic.selectedGenre == null
                              ? primaryColor.withOpacity(.5)
                              : logic.descriptionController.text == ''
                                  ? primaryColor.withOpacity(.5)
                                  : logic.titleController.text == ''
                                      ? primaryColor.withOpacity(.5)
                                      : primaryColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(50),
                          ),
                        ),
                        duration: const Duration(milliseconds: 200),
                        child: Center(
                          child: Text(
                            'Generate',
                            style: TextStyle(
                              fontSize: 22.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    SizedBox(
                      height: 90.h,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
