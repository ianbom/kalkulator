
import 'package:flutter_application/login_laravel/helper/constant.dart';
import 'package:flutter/material.dart';

InputField({
  required double width,
  required TextEditingController controller,
  required String hintText,
  bool isObscure = false,
}) {
  return Container(
    width: width * 0.8,
    padding: const EdgeInsets.symmetric(
      horizontal: 20,
    ),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintStyle: TextStyle(
          color: Colors.white,
          fontSize: 22,
        ),
        hintText: hintText,
        border: InputBorder.none,
      ),
      obscureText: isObscure,
    ),
  );
}
