import 'package:flutter/material.dart';

import '../../../core/components/custom_button.dart';
import '../../../core/components/custom_text_form_field_item.dart';
import '../../../core/constants/colors.dart';
import '../../../data/models/user_model.dart';
import '../../../data/services/firebase_auth_service.dart';
import '../../home/pages/dashboard_page.dart';

class CustomTextFormFieldLogin extends StatefulWidget {
  const CustomTextFormFieldLogin({super.key});

  @override
  State<CustomTextFormFieldLogin> createState() =>
      _CustomTextFormFieldLoginState();
}

class _CustomTextFormFieldLoginState extends State<CustomTextFormFieldLogin> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController emailAddressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> _login() async {
    try {
      String email = emailAddressController.text;
      String password = passwordController.text;

      UserModel user = await _auth.login(email: email, password: password);

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return DashboardPage(user: user);
      }));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.kGreenColor,
          content: Text("Berhasil Login"),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.kRedColor,
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  void dispose() {
    emailAddressController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
              onTap: () {},
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
              _login();
            },
          ),
        ],
      ),
    );
  }
}
