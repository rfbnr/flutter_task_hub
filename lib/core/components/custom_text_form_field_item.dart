import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/font_weight.dart';

class CustomTextFormFieldItem extends StatelessWidget {
  const CustomTextFormFieldItem({
    super.key,
    required this.title,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.controller,
  });

  final String title;
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: AppFontWeight.regular,
            ),
          ),
          const SizedBox(height: 6),
          TextField(
            cursorColor: AppColors.kBlackColor,
            obscureText: obscureText,
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                color: AppColors.kGreyColor,
              ),
              suffixIcon: suffixIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: const BorderSide(
                  color: AppColors.kPrimaryColor,
                  width: 3,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: const BorderSide(
                  color: AppColors.kPrimaryColor,
                  width: 1.5,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
