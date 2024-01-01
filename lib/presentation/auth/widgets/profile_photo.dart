import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_hub/core/constants/colors.dart';

class ProfilePhoto extends StatefulWidget {
  const ProfilePhoto({super.key});

  @override
  State<ProfilePhoto> createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<ProfilePhoto> {
  File? _image;

  Future<void> _getImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
              image: _image != null
                  ? DecorationImage(
                      fit: BoxFit.cover,
                      image: FileImage(_image!),
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
              if (_image != null) {
                setState(() {
                  _image = null;
                });
              } else {
                _getImageFromGallery();
              }
            },
            child: Text(_image != null ? "Hapus Foto" : "Pilih Foto"),
          ),
        ],
      ),
    );
  }
}
