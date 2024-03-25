import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:myth_maker/consts.dart';
import 'package:myth_maker/login/view.dart';
import 'package:myth_maker/navbar/logic.dart';
import 'package:myth_maker/utils/TokenUtils.dart';

import 'navbar/view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print( await TokenUtils.retrieveToken());
  String Token=await TokenUtils.retrieveToken();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.black,
    statusBarIconBrightness: Brightness.light,
  ));
  await NavbarLogic().fetchUserData();

  runApp(MyApp(token: Token,));
}

class MyApp extends StatefulWidget {
  MyApp({super.key, required this.token});

  String token;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
        if (result == ConnectivityResult.none) {
          Fluttertoast.showToast(
            msg: 'No Internet Connection',
            gravity: ToastGravity.CENTER,
            toastLength: Toast.LENGTH_LONG,
          );
        } else {
          NavbarLogic().fetchUserData();
        }
      },
    );
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: widget.token==''
            ? LoginPage()
            : NavbarPage(),
      ),
    );
  }
}
