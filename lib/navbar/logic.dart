import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:myth_maker/consts.dart';
import 'package:myth_maker/home/view.dart';
import 'package:myth_maker/profile/view.dart';
import 'package:http/http.dart' as http;
import 'package:myth_maker/utils/TokenUtils.dart';
import 'package:myth_maker/utils/userInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import '../models/User.dart';
import 'dart:math' as math;

class NavbarLogic extends GetxController {
  final ScrollController scrollController = ScrollController();
  int index = 0;
  late User user;
  var pages = [
    HomePage(),
    ProfilePage(),
  ];


  changeIndex(int index) {

    if (this.index != index) {
      this.index = index;
      update();
    } else {
      scrollController.animateTo(
        0,
        duration: Duration(milliseconds: 700),
        curve: Curves.easeIn,
      );
    }
  }

  Future<User?> fetchUserData() async {
    const int maxRetries = 3;
    const Duration initialDelay = Duration(seconds: 2);
    int retryCount = 0;

    while (retryCount < maxRetries) {
      try {
        String apiUrl = '$backendLink/getUserInfo';
        String token = await TokenUtils.retrieveToken();
        final response = await http.get(
          Uri.parse(apiUrl),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        );

        if (response.statusCode == 200) {
          final userData = json.decode(response.body);
          user = User.fromJson(userData);
          UserData().setUser(user.id, user.name, user.email, user.pfp);

          return user;
        } else {}
      } catch (e) {}

      await Future.delayed(initialDelay * math.pow(2, retryCount));
      retryCount++;
    }

    return null;
  }
}
