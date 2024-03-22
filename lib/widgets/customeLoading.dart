import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class customeLoading extends StatelessWidget {
  const customeLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/lottie/loading.json',
      frameRate: FrameRate(60),
      width: 150.w
    );
  }
}
