import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/components/custom_button.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/font_weight.dart';
import '../../../data/models/user_model.dart';
import '../../auth/pages/login_page.dart';
import '../widgets/card_profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        children: [
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: const Text(
              "My Profile",
              style: TextStyle(
                fontSize: 24,
                fontWeight: AppFontWeight.semiBold,
              ),
            ),
          ),
          CardProfile(user: user),
          CustomButton(
            title: "Logout",
            margin: const EdgeInsets.symmetric(vertical: 30),
            onPressed: () {
              try {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const LoginPage();
                  }),
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: AppColors.kGreenColor,
                    content: Text("Berhasil Logout"),
                  ),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: AppColors.kGreenColor,
                    content: Text(e.toString()),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
