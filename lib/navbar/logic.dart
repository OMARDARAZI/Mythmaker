import 'dart:convert';

import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:myth_maker/consts.dart';
import 'package:myth_maker/home/view.dart';
import 'package:myth_maker/profile/view.dart';
import 'package:http/http.dart' as http;
import 'package:myth_maker/utils/TokenUtils.dart';

import '../models/User.dart';

class NavbarLogic extends GetxController {
  int index = 0;
  var pages = [
    HomePage(),
    ProfilePage(),
  ];

  changeIndex(int index) {
    this.index = index;
    update();
  }



  Future<User?> fetchUserData() async {
    String apiUrl = '$backendLink/getUserInfo';
    String token = await TokenUtils.retrieveToken();
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final userData = json.decode(response.body);
        return User.fromJson(userData);
      } else {
        print('Failed to fetch user data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
    }
  }
}
