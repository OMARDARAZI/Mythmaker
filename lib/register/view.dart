import 'package:all_validations_br/all_validations_br.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Add this import for date formatting
import 'package:myth_maker/widgets/primaryBtn.dart';
import 'package:smooth_scroll_multiplatform/smooth_scroll_multiplatform.dart';
import '../consts.dart';
import '../widgets/TextField.dart';
import 'logic.dart'; // Adjust if your logic class is different for registration

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController dobController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<RegisterLogic>(
          init: RegisterLogic(),
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
                          fontSize: 17.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 50.h),
                    Form(
                      key: logic.formKey,
                      child: Column(
                        children: [
                          customeTextField(
                            hint: 'Full Name',
                            controller: fullNameController,
                            keyboardType: TextInputType.name,
                            validator: (p0) {
                              if(p0==''){
                                return 'Enter your name';
                              }
                              else if(p0!.length<3){
                                return 'At least 3 characters';
                              }
                            },
                          ),
                          SizedBox(height: 40.h),
                          customeTextField(
                            validator: (p0) {
                              if(p0==''){
                                return 'Enter your Email';
                              }
                              else if(!AllValidations.isEmail(p0!)){
                                return 'Enter a valid Email Address';
                              }
                            },
                            hint: 'Email',
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 40.h),
                          customeTextField(
                            hint: 'Password',
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (p0) {
                              if(!AllValidations.isMediumPassword(p0!)){
                                return 'Password requirements: \n- At least 6 characters \n- At least 1 uppercase letter \n- At least 1 lowercase letter \n- At least 1 number';
                                // return 'Password should contain\nAt least 6 characters\n1 Uppercase letter\n1 Lowercase letter\nand 1 number';
                              }
                            },
                          ),
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
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                dobController.text =
                                    formattedDate;
                              }
                            },
                            child: AbsorbPointer(
                              child: customeTextField(
                                validator: (p0) {
                                  if(p0==''){
                                    return 'Select Date of birth';
                                  }
                                },
                                hint: 'Date of Birth',
                                controller:
                                    dobController,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 70.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if(logic.formKey.currentState!.validate()){
                              if (logic.isLoading == false) {
                                logic.registerUser(
                                  name: fullNameController.text.trim(),
                                  email:
                                  emailController.text.toLowerCase().trim(),
                                  password: passwordController.text.trim(),
                                  dob: dobController.text,
                                  context: context,
                                );
                              }
                            }
                          },
                          child: primaryBtn(
                            text: 'Register',
                            isLoading: logic.isLoading,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 50.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                  fontSize: 15.sp, color: Colors.black),
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
            );
          }),
    );
  }
}

// Replace the customeTextField function with your actual customTextField implementation. This example assumes you have a predefined function or widget for creating text fields.
