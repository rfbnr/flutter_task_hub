import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../data/models/user_model.dart';
import 'profile_item.dart';
import 'profile_photo.dart';

class CardProfile extends StatelessWidget {
  const CardProfile({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 30),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: AppColors.kWhiteColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.kGreyColor.withOpacity(0.3),
            blurRadius: 50,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfilePhoto(user: user),
          ProfileItem(
            title: "Name",
            valueTitle: user.name,
            valueColor: AppColors.kBlackColor,
          ),
          ProfileItem(
            title: "Email",
            valueTitle: user.email,
            valueColor: AppColors.kBlackColor,
          ),
          ProfileItem(
            title: "Role",
            valueTitle: user.role,
            valueColor: AppColors.kRedColor,
          ),
        ],
      ),
    );
  }
}
