import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:myth_maker/consts.dart';
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
          body: Center(child: logic.pages[logic.index]),
          floatingActionButton: Padding(
            padding: EdgeInsets.all(10.w),
            child: FloatingActionButton(
              backgroundColor: primaryColor,
              onPressed: () {},
              elevation: 2.0,
              child: const Icon(Icons.add),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
              child: BottomAppBar(
                elevation: 10,
                height: 80.h,
                shape: const CircularNotchedRectangle(),
                notchMargin: 5.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Row(
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
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
