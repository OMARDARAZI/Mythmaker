import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:myth_maker/consts.dart';
import 'package:myth_maker/story_data/view.dart';
import 'logic.dart';

class NavbarPage extends StatelessWidget {
  const NavbarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavbarLogic>(
      init: NavbarLogic(),
      builder: (logic) {
        return Scaffold(
          backgroundColor: backgroundColor,
          body: Stack(
            children: [
              logic.pages[logic.index],
              Positioned(
                bottom: 20,
                right: 25,
                left: 25,
                child: ClipPath(
                  clipper: NotchClipper(),
                  child: Container(
                    width: 350.w,
                    height: 100.h,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                        bottomRight: Radius.circular(47.18),
                        bottomLeft: Radius.circular(47.18),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            InkWell(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(100)),
                              onTap: () {
                                logic.changeIndex(0);
                              },
                              child: SizedBox(
                                width: 80.w,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Iconsax.home,
                                      size: 30.w,
                                      color: logic.index == 0
                                          ? primaryColor
                                          : Colors.grey,
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text(
                                      'Home',
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        color: logic.index == 0
                                            ? primaryColor
                                            : Colors.grey,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 40.w,
                            ),
                            InkWell(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(100)),
                              onTap: () {
                                logic.changeIndex(1);
                              },
                              child: SizedBox(
                                width: 80.w,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Iconsax.profile_circle,
                                      size: 30.w,
                                      color: logic.index == 1
                                          ? primaryColor
                                          : Colors.grey,
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text(
                                      'Profile',
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        color: logic.index == 1
                                            ? primaryColor
                                            : Colors.grey,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          floatingActionButton: Padding(
            padding: EdgeInsets.symmetric(vertical: 80.h),
            child: FloatingActionButton(
              backgroundColor: primaryColor,
              onPressed: () {
                Get.to(()=>StoryDataPage());
              },
              elevation: 2.0,
              child: const Icon(Icons.add),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }
}

class NotchClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double notchSize = 70; // Diameter of the notch
    Path path = Path();

    path.lineTo(0, 0);

    path.lineTo((size.width / 2) - (notchSize / 2), 0);

    path.arcToPoint(
      Offset((size.width / 2) + (notchSize / 2), 0),
      radius: Radius.circular(notchSize / 2),
      clockwise: false,
    );
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
