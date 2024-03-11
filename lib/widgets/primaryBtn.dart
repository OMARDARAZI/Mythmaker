import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:myth_maker/consts.dart';

class primaryBtn extends StatelessWidget {
   primaryBtn({super.key,required this.text,required this.isLoading});
   bool isLoading;
  String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350.w,
      height:70.h,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(50))
      ),
      child: isLoading?Lottie.asset('assets/lottie/loading.json',frameRate: FrameRate(60)): Center(
        child:Text(text,style: TextStyle( fontSize: 22.sp,color: Colors.white,fontWeight: FontWeight.bold)),
      ),
    );
  }
}
