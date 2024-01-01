import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_hub/presentation/home/pages/dashboard_page.dart';

import '../../../core/components/custom_button.dart';
import '../../../core/components/custom_text_form_field_item.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/font_weight.dart';
import '../../../data/models/user_model.dart';
import '../../../data/services/firebase_auth_service.dart';

class CustomTextFormFieldRegister extends StatefulWidget {
  const CustomTextFormFieldRegister({super.key});

  @override
  State<CustomTextFormFieldRegister> createState() =>
      _CustomTextFormFieldRegisterState();
}

class _CustomTextFormFieldRegisterState
    extends State<CustomTextFormFieldRegister> {
  File? image;
  String _userRole = "user";

  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> getImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }

  Future<void> _register() async {
    try {
      String fullName = nameController.text;
      String email = emailAddressController.text;
      String password = passwordController.text;

      UserModel user = await _auth.register(
        name: fullName,
        email: email,
        password: password,
        role: _userRole,
        photo: image.toString(),
      );

      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return DashboardPage(user: user);
      }), (route) => false);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.kGreenColor,
          content: Text("Berhasil Register"),
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
    nameController.dispose();
    emailAddressController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget radioButton() {
      return Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Roles",
              style: TextStyle(
                fontSize: 14,
                fontWeight: AppFontWeight.regular,
              ),
            ),
            const SizedBox(height: 6),
            RadioListTile(
              value: "user",
              title: const Text("User"),
              groupValue: _userRole,
              onChanged: (value) {
                setState(() {
                  _userRole = value as String;
                });
              },
            ),
            RadioListTile(
              value: "admin",
              title: const Text("Admin"),
              groupValue: _userRole,
              onChanged: (value) {
                setState(() {
                  _userRole = value as String;
                });
              },
            ),
          ],
        ),
      );
    }

    Widget profilePhoto() {
      return Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.kGreyColor,
                image: image != null
                    ? DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(image!),
                      )
                    : const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/img-user2.png"),
                      ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (image != null) {
                  setState(() {
                    image = null;
                  });
                } else {
                  getImageFromGallery();
                }
              },
              child: Text(image != null ? "Hapus Foto" : "Pilih Foto"),
            ),
          ],
        ),
      );
    }

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
          profilePhoto(),
          CustomTextFormFieldItem(
            title: "Full Name",
            hintText: "Your full name",
            controller: nameController,
          ),
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
          radioButton(),
          CustomButton(
            title: "Register",
            margin: const EdgeInsets.only(top: 20),
            onPressed: () {
              _register();
            },
          ),
        ],
      ),
    );
  }
}
