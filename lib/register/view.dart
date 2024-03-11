import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Add this import for date formatting
import 'package:myth_maker/widgets/primaryBtn.dart';
import '../consts.dart';
import '../widgets/TextField.dart';
import 'logic.dart'; // Adjust if your logic class is different for registration

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController dobController = TextEditingController(); // Will be used to display the selected date

  final logic = Get.put(RegisterLogic()); // Adjust if you have a separate logic for registration

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SingleChildScrollView( // Make sure your content is scrollable
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: 140.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Text(
                  'Register',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 35.sp),
                ),
              ),
              SizedBox(height: 5.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Text(
                  'Please Sign Up To Continue',
                  style: TextStyle(
                    color: Colors.black.withOpacity(.5),
                    fontSize: 17.sp,),
                ),
              ),
              SizedBox(height: 50.h),
              customeTextField(hint: 'Full Name', controller: fullNameController),
              SizedBox(height: 40.h),
              customeTextField(hint: 'Email', controller: emailController),
              SizedBox(height: 40.h),
              customeTextField(hint: 'Password', controller: passwordController),
              SizedBox(height: 40.h),
              GestureDetector(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                    dobController.text = formattedDate; // Update the text of the controller with the formatted date
                  }
                },
                child: AbsorbPointer(
                  child: customeTextField(
                    hint: 'Date of Birth',
                    controller: dobController, // This controller will now display the selected date
                  ),
                ),
              ),
              SizedBox(height: 70.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  primaryBtn(text: 'Register', isLoading: logic.isLoading),
                ],
              ),
              SizedBox(height:50.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 15.sp, color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(text: "Already have an account? "),
                          TextSpan(
                            text: 'Sign In',
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

// Replace the customeTextField function with your actual customTextField implementation. This example assumes you have a predefined function or widget for creating text fields.
