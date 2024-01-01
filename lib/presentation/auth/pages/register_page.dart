import 'package:flutter/material.dart';

import '../../../core/components/custome_tac_button.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/font_weight.dart';
import '../widgets/custom_text_form_field_register.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                "Register",
                style: TextStyle(
                  color: AppColors.kBlackColor,
                  fontSize: 24,
                  fontWeight: AppFontWeight.semiBold,
                ),
              ),
            ),
            const CustomTextFormFieldRegister(),
            CustomTACButton(
              title: "Have an account? Login",
              margin: const EdgeInsets.only(top: 50, bottom: 73),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const LoginPage();
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
