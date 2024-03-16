

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

Future<String?> Login(String email, String password,BuildContext context) async {
  isLoading=true;
  update();
  try {

    final response = await http.post(
      Uri.parse('${backendLink}/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      isLoading=false;
      update();
      final data = json.decode(response.body);
      await TokenUtils.saveToken(data['token']);
      print(await TokenUtils.retrieveToken());

        Get.offAll(()=>NavbarPage(),transition: Transition.rightToLeftWithFade);
      return data['token'];
    } else if (response.statusCode == 404) {
      isLoading=false;
      update();
      print("User not found.");

      errorDialog(
        context,
        "Error",
        "User not found",
        positiveButtonText: "OK",
        positiveButtonAction: () {},
        negativeButtonText: "",
        negativeButtonAction: () {},
        neutralButtonText: "",
        neutralButtonAction: () {},
        hideNeutralButton: false,
        closeOnBackPress: false,
      );
      return null;
    } else if (response.statusCode == 400) {
      isLoading=false;
      update();
      print("Invalid email or password.");
      errorDialog(
        context,
        "Error",
        "Invalid email or password.",
        positiveButtonText: "OK",
        positiveButtonAction: () {},
        negativeButtonText: "",
        negativeButtonAction: () {},
        neutralButtonText: "",
        neutralButtonAction: () {},
        hideNeutralButton: false,
        closeOnBackPress: false,
      );
      return null;
    } else {
      isLoading=false;
      update();
      errorDialog(
        context,
        "Error",
        "${response.body}.",
        positiveButtonText: "OK",
        positiveButtonAction: () {},
        negativeButtonText: "",
        negativeButtonAction: () {},
        neutralButtonText: "",
        neutralButtonAction: () {},
        hideNeutralButton: false,
        closeOnBackPress: false,
      );
      print("Error: ${response.body}");
      return null;
    }
  } catch (e) {
    isLoading=false;
    update();
    errorDialog(
      context,
      "Error",
      "${e}.",
      positiveButtonText: "OK",
      positiveButtonAction: () {},
      negativeButtonText: "",
      negativeButtonAction: () {},
      neutralButtonText: "",
      neutralButtonAction: () {},
      hideNeutralButton: false,
      closeOnBackPress: false,
    );
    print("Error: $e");
    return null;
  }
}
}