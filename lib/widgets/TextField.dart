import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class customeTextField extends StatelessWidget {
  customeTextField({super.key,required this.hint,required this.controller});

  String hint;
  TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(),
        decoration:  InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.w)),
            borderSide: BorderSide.none
          ),
        ),
      ),
    );
  }
}
