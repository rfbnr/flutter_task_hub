import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/font_weight.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.margin = EdgeInsets.zero,
    this.width = double.infinity,
  });

  final String title;
  final double width;
  final EdgeInsets margin;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: width,
      margin: margin,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: AppColors.kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: AppColors.kWhiteColor,
            fontSize: 18,
            fontWeight: AppFontWeight.medium,
          ),
        ),
      ),
    );
  }
}
