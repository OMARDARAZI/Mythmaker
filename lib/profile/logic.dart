import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:myth_maker/consts.dart';
import 'package:myth_maker/utils/userInfo.dart';

import '../models/Post.dart';
import '../models/User.dart';
import '../navbar/logic.dart';

class ProfileLogic extends GetxController {
  late Future<User?> userDataFuture;
  late Future<List<Post>> postsFuture;

  late String userId;

  Future<String?> uploadImageToImgBB(File imageFile) async {
    final url = Uri.parse('https://api.imgbb.com/1/upload');

    try {
      final request = http.MultipartRequest('POST', url)
        ..fields['key'] = imgBBApi
        ..files.add(await http.MultipartFile.fromPath(
          'image',
          imageFile.path,
        ));

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        return json['data']['url'];
      } else {
        print('Failed to upload image. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    userDataFuture = NavbarLogic().fetchUserData();

    userId = '${UserData().id}';
    postsFuture = fetchPostsByUserId(userId);
  }
}
