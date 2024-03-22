import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

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
}
