import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:myth_maker/register/view.dart';
import 'package:myth_maker/widgets/TextField.dart';
import 'package:myth_maker/widgets/primaryBtn.dart';
import '../consts.dart';
import 'logic.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<LoginLogic>(
        init: LoginLogic(),
        builder: (logic) {
          return Scaffold(
            backgroundColor: backgroundColor,
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 170.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Text(
                      'Login',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 35.sp),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Text(
                      'Please Sign In To Continue',
                      style: TextStyle(
                        color: Colors.black.withOpacity(.5),
                        fontSize: 17.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 100.h),
                  customeTextField(
                    onChanged: (p0) {
                      logic.updateUi();
                    },
                    hint: 'Email',
                    controller: logic.emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  customeTextField(
                    maxLines: 1,
                    onChanged: (p0) => logic.updateUi(),
                    hint: 'Password',
                    controller: logic.passwordController,
                    isObscure: logic.isObscure,
                    suffixIcon: IconButton(
                      onPressed: () {
                        logic.changeObscure();
                      },
                      icon: Icon(
                        logic.isObscure ? Iconsax.eye : Iconsax.eye_slash,
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 15.sp,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 70.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (logic.isLoading == false) {
                            FocusManager.instance.primaryFocus?.unfocus();

                            if (logic.emailController.text == '' ||
                                logic.passwordController.text == '') {
                            } else {
                              logic.login(
                                  logic.emailController.text
                                      .trim()
                                      .toLowerCase(),
                                  logic.passwordController.text.trim(),
                                  context);
                            }
                          }
                        },
                        child: AnimatedContainer(
                          width: 350.w,
                          height: 70.h,
                          decoration: BoxDecoration(
                            color: logic.emailController.text == ''
                                ? primaryColor.withOpacity(.5)
                                : logic.passwordController.text == ''
                                    ? primaryColor.withOpacity(.5)
                                    : primaryColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(50),
                            ),
                          ),
                          duration: Duration(milliseconds: 200),
                          child: logic.isLoading
                              ? Lottie.asset('assets/lottie/loading.json',
                                  frameRate: FrameRate(60))
                              : Center(
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                      fontSize: 22.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 130.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(() => RegisterPage(),
                              transition: Transition.rightToLeftWithFade);
                        },
                        child: RichText(
                          text: TextSpan(
                            style:
                                TextStyle(fontSize: 15.sp, color: Colors.black),
                            children: <TextSpan>[
                              const TextSpan(text: "Don't Have An Account? "),
                              TextSpan(
                                text: 'Create One',
                                style: TextStyle(color: primaryColor),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
