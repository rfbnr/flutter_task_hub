import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/font_weight.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    super.key,
    required this.title,
    required this.valueColor,
    required this.valueTitle,
  });

  final String title;
  final String valueTitle;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.kBlackColor,
            ),
          ),
          const Spacer(),
          Text(
            valueTitle,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.kBlackColor,
              fontWeight: AppFontWeight.semiBold,
            ),
          ),
        ],
      ),
    );
  }
}
