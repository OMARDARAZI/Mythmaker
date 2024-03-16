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
    required BuildContext context,
  }) async {
    final Uri apiUrl = Uri.parse("${backendLink}/register");
    isLoading=true;
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
        }),
      );

      if (response.statusCode == 200) {
        isLoading=false;
        update();
        final userData = jsonDecode(response.body);
        loginLogic.Login(email, password, context);
      } else if (response.statusCode == 400) {
        isLoading=false;
        update();
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
          hideNeutralButton: false,
          closeOnBackPress: false,
        );
      } else {
        isLoading=false;
        update();
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
          hideNeutralButton: false,
          closeOnBackPress: false,
        );
        throw Exception('Failed to register user.');
      }
    } catch (e) {
      isLoading=false;
      update();


    }
  }

}
