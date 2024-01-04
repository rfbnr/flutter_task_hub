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
  bool isLoading = false;
  bool passwordVisibility = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
            title: "Email",
            hintText: "Masukkan email anda",
            controller: emailController,
          ),
          CustomTextFormFieldItem(
            title: "Password",
            hintText: "Masukkan password anda",
            obscureText: passwordVisibility,
            controller: passwordController,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  passwordVisibility = !passwordVisibility;
                });
              },
              child: Icon(
                passwordVisibility ? Icons.visibility_off : Icons.visibility,
                color: AppColors.kGreyColor,
              ),
            ),
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : CustomButton(
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

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    try {
      String email = emailController.text;
      String password = passwordController.text;

      if (email.isEmpty && password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppColors.kRedColor,
            content: Text("Silahkan isi email & password anda!"),
          ),
        );
      } else if (email.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppColors.kRedColor,
            content: Text("Silahkan isi email anda!"),
          ),
        );
      } else if (password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppColors.kRedColor,
            content: Text("Silahkan isi password anda!"),
          ),
        );
      } else {
        setState(() {
          isLoading = true;
        });

        UserModel user = await _auth.login(email: email, password: password);

        Future.microtask(() {
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) {
            return DashboardPage(user: user);
          }), (route) => false);

          setState(() {
            isLoading = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: AppColors.kGreenColor,
              content: Text("Berhasil Login"),
            ),
          );
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.kRedColor,
          content: Text(e.toString()),
        ),
      );

      setState(() {
        isLoading = false;
      });
    }
  }
}
