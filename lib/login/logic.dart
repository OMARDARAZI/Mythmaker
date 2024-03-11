import 'package:get/get.dart';

class LoginLogic extends GetxController {

  bool isLoading = false;

  login(){
    isLoading=true;
    update();
  }
}
