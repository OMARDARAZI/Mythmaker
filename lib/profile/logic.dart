import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:myth_maker/consts.dart';

class ProfileLogic extends GetxController {



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
}
