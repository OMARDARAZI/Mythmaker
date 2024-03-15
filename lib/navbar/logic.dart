import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:myth_maker/home/view.dart';
import 'package:myth_maker/profile/view.dart';

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
}
