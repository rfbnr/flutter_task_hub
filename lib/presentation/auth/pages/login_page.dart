import 'package:flutter/material.dart';

import '../../../core/components/custome_tac_button.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/font_weight.dart';
import '../widgets/custom_text_form_field_login.dart';
import 'register_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          children: [
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: const Text(
                "Login",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: AppFontWeight.semiBold,
                ),
              ),
            ),
            const CustomTextFormFieldLogin(),
            CustomTACButton(
              title: "Belum punya akun? Register",
              margin: const EdgeInsets.only(top: 50, bottom: 73),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const RegisterPage();
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
