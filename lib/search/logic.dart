import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:myth_maker/consts.dart';

class SearchLogic extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  TextEditingController searchController = TextEditingController();

  clearSearch() {
    searchController.text='';
    update();
  }



  Future<List<dynamic>?> searchUsers(String searchQuery) async {
    try {
      final response = await http.get(Uri.parse('$backendLink/searchUsers?name=$searchQuery'));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 404) {
        print("No users found matching the search criteria.");
        return null;
      } else {
        print('Failed to load users');
        return null;
      }
    } catch (error) {
      print("An error occurred during the search process: $error");
      return null;
    }
  }
}

