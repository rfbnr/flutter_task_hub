import 'package:flutter/material.dart';

import '../../../core/components/custom_button.dart';
import '../../../core/components/custom_text_form_field_item.dart';
import '../../../core/constants/colors.dart';
import 'profile_photo.dart';
import 'radio_button.dart';

class CustomTextFormFieldRegister extends StatelessWidget {
  CustomTextFormFieldRegister({super.key});

  final TextEditingController nameController = TextEditingController(text: "");
  final TextEditingController emailAddressController =
      TextEditingController(text: "");
  final TextEditingController passwordController =
      TextEditingController(text: "");
  final TextEditingController hobbyController = TextEditingController(text: "");

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
          const ProfilePhoto(),
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
              // onLongPressUp: () => setState.toggleVisibility(),
              // onLongPress: () => setState.toggleVisibility(),
              child: const Icon(
                Icons.visibility_off,
                color: AppColors.kGreyColor,
              ),
            ),
          ),
          const RadioButton(),
          CustomButton(
            title: "Register",
            margin: const EdgeInsets.only(top: 20),
            onPressed: () {
              // context.read<AuthCubit>().signUp(
              //       name: nameController.text,
              //       email: emailAddressController.text,
              //       password: passwordController.text,
              //       hobby: hobbyController.text,
              //     );
            },
          ),
        ],
      ),
    );
  }
}
