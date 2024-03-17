

// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:fialogs/fialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:myth_maker/consts.dart';
import 'package:myth_maker/navbar/view.dart';
import 'package:myth_maker/utils/TokenUtils.dart';
class LoginLogic extends GetxController {

  bool isLoading = false;
  bool isObscure=true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  changeObscure(){
    isObscure=!isObscure;
    update();
  }

  updateUi(){
    update();
  }

  Future<String?> login(String email, String password, BuildContext context) async {
    isLoading = true;
    update(); // Assuming 'update' is a method to refresh UI, make sure it's correctly implemented.

    try {
      final response = await http.post(
        Uri.parse('$backendLink/login'), // Ensure 'backendLink' is defined and correct.
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      isLoading = false;
      update();

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        await TokenUtils.saveToken(data['accessToken']); // Corrected from 'token' to 'accessToken'.
        print(await TokenUtils.retrieveToken());

        Get.offAll(() => NavbarPage(), transition: Transition.rightToLeftWithFade); // Make sure NavbarPage is defined.
        return data['accessToken'];
      } else {
        // Handle errors more generically to avoid redundancy.
        String errorMessage = "An unexpected error occurred.";
        if (response.statusCode == 404 || response.statusCode == 400) {
          errorMessage = "Invalid email or password.";
        }
        print(errorMessage);
        errorDialog(
          context,
          "Error",
          errorMessage,
          positiveButtonText: "OK",
          positiveButtonAction: () {},
          negativeButtonText: "",
          negativeButtonAction: () {},
          neutralButtonText: "",
          neutralButtonAction: () {},
          hideNeutralButton: true, // Assuming you want to hide the neutral button by default.
          closeOnBackPress: false,
        );
        return null;
      }
    } catch (e) {
      isLoading = false;
      update();
      print("Error: $e");
      errorDialog(
        context,
        "Error",
        "Failed to connect. Please try again later.",
        positiveButtonText: "OK",
        positiveButtonAction: () {},
        negativeButtonText: "",
        negativeButtonAction: () {},
        neutralButtonText: "",
        neutralButtonAction: () {},
        hideNeutralButton: true,
        closeOnBackPress: false,
      );
      return null;
    }
  }

}