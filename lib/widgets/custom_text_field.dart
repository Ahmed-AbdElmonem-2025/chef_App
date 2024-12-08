import 'package:chief_app/shared/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    Key? key,
    required this.controller,
      this.hintText,
      this.label,
      this.validator,
    this.isPassword = false, 
    this.suffixIcon,
  }) : super(key: key);
  TextEditingController controller;
  final String? hintText;
  final String? label;
  final String? Function(String?)? validator;
  final bool isPassword;
  final Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      cursorColor: AppColors.primaryColor,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: label,
        suffixIcon:  suffixIcon   ,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
