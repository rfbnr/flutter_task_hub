import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/components/custom_button.dart';
import '../../../core/constants/colors.dart';
import '../../../data/models/user_model.dart';
import '../../auth/pages/login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Name : ${user.name}"),
          Text("Email : ${user.email}"),
          Text("Role : ${user.role}"),
          CustomButton(
            title: "Logout",
            margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
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
