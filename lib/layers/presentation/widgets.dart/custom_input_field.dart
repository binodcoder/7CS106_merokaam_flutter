import 'package:flutter/material.dart';
import '../../../resources/colour_manager.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final IconButton? suffixIcon;
  final bool? obscureText;
  final int? maxLines;
  final int? minLines;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    this.validator,
    required this.hintText,
    this.suffixIcon,
    this.obscureText,
    this.maxLines,
    this.minLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines ?? 1,
      minLines: minLines ?? 1,
      obscureText: obscureText ?? false,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        border: InputBorder.none,
        fillColor: ColorManager.redWhite,
        filled: true,
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.blueGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.red),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.red),
        ),
      ),
    );
  }
}
