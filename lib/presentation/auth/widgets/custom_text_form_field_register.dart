import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/components/custom_button.dart';
import '../../../core/components/custom_text_form_field_item.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/font_weight.dart';
import '../../../data/models/user_model.dart';
import '../../../data/services/firebase_auth_service.dart';
import '../../../data/services/firebase_user_service.dart';
import '../../home/pages/dashboard_page.dart';

class CustomTextFormFieldRegister extends StatefulWidget {
  const CustomTextFormFieldRegister({super.key});

  @override
  State<CustomTextFormFieldRegister> createState() =>
      _CustomTextFormFieldRegisterState();
}

class _CustomTextFormFieldRegisterState
    extends State<CustomTextFormFieldRegister> {
  bool isLoading = false;
  bool passwordVisibility = true;
  File? image;
  String userRole = "user";

  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController nameController = TextEditingController();
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
          profilePhoto(),
          CustomTextFormFieldItem(
            title: "Nama",
            hintText: "Masukkan nama anda",
            controller: nameController,
          ),
          CustomTextFormFieldItem(
            title: "Email",
            hintText: "Masukka email anda",
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
          radioButton(),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : CustomButton(
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

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget radioButton() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Role",
            style: TextStyle(
              fontSize: 14,
              fontWeight: AppFontWeight.regular,
            ),
          ),
          const SizedBox(height: 6),
          RadioListTile(
            value: "user",
            title: const Text("User"),
            groupValue: userRole,
            onChanged: (value) {
              setState(() {
                userRole = value as String;
              });
            },
          ),
          RadioListTile(
            value: "admin",
            title: const Text("Admin"),
            groupValue: userRole,
            onChanged: (value) {
              setState(() {
                userRole = value as String;
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
      String photoUrl = "";
      String fullName = nameController.text;
      String email = emailController.text;
      String password = passwordController.text;

      setState(() {
        isLoading = true;
      });

      if (image != null) {
        photoUrl = await FirebaseUserService().uploadImgToFirebase(image!);
      } else {
        photoUrl = "";
      }

      UserModel user = await _auth.register(
        name: fullName,
        email: email,
        password: password,
        role: userRole,
        photo: photoUrl,
      );

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
            content: Text("Berhasil Register"),
          ),
        );
      });
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
