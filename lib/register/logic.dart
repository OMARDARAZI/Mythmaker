// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:fialogs/fialogs.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myth_maker/consts.dart';
import 'package:myth_maker/login/logic.dart';

class RegisterLogic extends GetxController {

  bool isLoading =false;
  final formKey = GlobalKey<FormState>();
  final loginLogic = Get.put(LoginLogic());

  updateUi(){
    update();
  }
  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
    required String dob,
    // Assuming bio and pfp are optional and have default values. Adjust as needed.
    String bio = '',
    String pfp = '',
    required BuildContext context,
  }) async {
    final Uri apiUrl = Uri.parse("$backendLink/register");
    isLoading = true;
    update();
    try {
      final response = await http.post(
        apiUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': name,
          'email': email,
          'password': password,
          'dob': dob,
          'bio': bio,
          'pfp': pfp,
        }),
      );

      isLoading = false;
      update();

      if (response.statusCode == 201) {
        final userData = jsonDecode(response.body);
        loginLogic.login(email, password, context);
      } else if (response.statusCode == 400) {
        errorDialog(
          context,
          "Error",
          "User already registered.",
          positiveButtonText: "OK",
          positiveButtonAction: () {},
          negativeButtonText: "",
          negativeButtonAction: () {},
          neutralButtonText: "",
          neutralButtonAction: () {},
          hideNeutralButton: true,
          closeOnBackPress: false,
        );
      } else {
        errorDialog(
          context,
          "Error",
          "Failed to register user.",
          positiveButtonText: "OK",
          positiveButtonAction: () {},
          negativeButtonText: "",
          negativeButtonAction: () {},
          neutralButtonText: "",
          neutralButtonAction: () {},
          hideNeutralButton: true,
          closeOnBackPress: false,
        );
        throw Exception('Failed to register user.');
      }
    } catch (e) {
      isLoading = false;
      update();
      errorDialog(
        context,
        "Error",
        "An unexpected error occurred. Please try again later.",
        positiveButtonText: "OK",
        positiveButtonAction: () {},
        negativeButtonText: "",
        negativeButtonAction: () {},
        neutralButtonText: "",
        neutralButtonAction: () {},
        hideNeutralButton: true,
        closeOnBackPress: false,
      );
      print("Error during registration: $e");
    }
  }


}
