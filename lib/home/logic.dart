import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:myth_maker/consts.dart';
import 'package:myth_maker/utils/userInfo.dart';

import '../models/Post.dart';
import '../models/User.dart';

class HomeLogic extends GetxController {
  late Future<List<Post>> fetchPostsFuture;

  Future<List<Post>> fetchPosts(String userId) async {
    //

    final String apiUrl = '$backendLink/feed?userId=$userId';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> postsJson = json.decode(response.body);
      return postsJson.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<void> handleRefresh() async {
    fetchPostsFuture = fetchPosts(UserData().id.toString());
    await fetchPostsFuture;
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchPostsFuture = fetchPosts(UserData().id.toString());
    update();
  }

  Future<List<Post>> fetchPostsByUserId(String userId) async {
    final String apiUrl = '$backendLink/user/$userId/posts';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> postsJson = json.decode(response.body);
      return postsJson.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
