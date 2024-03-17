import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class customeTextField extends StatelessWidget {
  customeTextField({
    super.key,
    required this.hint,
    this.isObscure = false,
    required this.controller,
    this.suffixIcon,
    this.keyboardType,
    this.validator,
    required this.onChanged,
    this.maxLines,

  });

  String hint;
  bool isObscure;
  TextEditingController controller;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final void Function(String) onChanged;
  final String? Function(String?)? validator;

  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: TextFormField(
        onChanged: onChanged,
        validator: validator,
        keyboardType: keyboardType,
        obscureText: isObscure,
        controller: controller,
        maxLines: maxLines,
        style: const TextStyle(),
        decoration: InputDecoration(
          hintText: hint,
          suffixIcon: suffixIcon,
          suffixIconColor: Colors.grey,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.w)),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
