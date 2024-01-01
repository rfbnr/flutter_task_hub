import 'package:flutter/material.dart';

import '../../../core/components/custom_button.dart';
import '../../../core/components/custom_text_form_field_item.dart';
import '../../../core/constants/colors.dart';
import '../../home/pages/dashboard_page.dart';

class CustomTextFormFieldLogin extends StatelessWidget {
  CustomTextFormFieldLogin({super.key});

  final TextEditingController emailAddressController =
      TextEditingController(text: "");
  final TextEditingController passwordController =
      TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: BoxDecoration(
        color: AppColors.kWhiteColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.kGreyColor.withOpacity(0.3),
            blurRadius: 50,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          CustomTextFormFieldItem(
            title: "Email Address",
            hintText: "Your email address",
            controller: emailAddressController,
          ),
          CustomTextFormFieldItem(
            title: "Password",
            hintText: "Your Password",
            obscureText: true,
            controller: passwordController,
            suffixIcon: GestureDetector(
              // onLongPressUp: () => setState.toggleVisibility(),
              // onLongPress: () => setState.toggleVisibility(),
              child: const Icon(
                Icons.visibility_off,
                color: AppColors.kGreyColor,
              ),
            ),
          ),
          CustomButton(
            title: "Login",
            margin: const EdgeInsets.only(top: 20),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const DashboardPage();
              }));
            },
          ),
        ],
      ),
    );
  }
}
