import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:myth_maker/register/view.dart';
import 'package:myth_maker/widgets/TextField.dart';
import 'package:myth_maker/widgets/primaryBtn.dart';
import '../consts.dart';
import 'logic.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final logic = Get.put(LoginLogic());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
              SizedBox(height: 5.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Text(
                  'Please Sign In To Continue',
                  style: TextStyle(
                    color: Colors.black.withOpacity(.5),
                   fontSize: 17.sp,),
                ),
              ),
              SizedBox(height: 100.h),
              customeTextField(hint: 'Email', controller: emailController,),
              SizedBox(height: 40.h,),
              customeTextField(hint: 'Password', controller: passwordController,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w,vertical: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Forgot Password?',style: TextStyle(color: primaryColor,fontSize: 15.sp,),)
                  ],
                ),
              ),
              SizedBox(height: 70.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(child: primaryBtn(text: 'Login',isLoading: logic.isLoading),
                  onTap: () {
                    logic.login();
                    setState(() {

                    });

                  },),
                ],
              ),
              SizedBox(height: 130.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(()=>RegisterPage(),transition: Transition.rightToLeftWithFade);
                    },
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 15.sp, color: Colors.black), // Default text style
                        children: <TextSpan>[
                          TextSpan(text: "Don't Have An Account? "),
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
      ),
    );
  }
}
