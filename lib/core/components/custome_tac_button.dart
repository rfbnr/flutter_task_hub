import 'package:flutter/material.dart';
import 'package:task_hub/core/constants/colors.dart';

import '../constants/font_weight.dart';

class CustomTACButton extends StatelessWidget {
  const CustomTACButton({
    super.key,
    required this.title,
    required this.margin,
    required this.onPressed,
  });

  final String title;
  final void Function()? onPressed;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: margin,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: const TextStyle(
            color: AppColors.kGreyColor,
            fontSize: 16,
            fontWeight: AppFontWeight.light,
            decorationColor: AppColors.kGreyColor,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}
