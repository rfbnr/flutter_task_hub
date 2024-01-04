import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../../../core/constants/colors.dart';
import '../../../data/models/user_model.dart';

class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    Widget photoViewZoom() {
      ImageProvider<Object>? selectedImageProvider;
      if (user.photo.isNotEmpty) {
        selectedImageProvider = NetworkImage(user.photo);
      } else {
        selectedImageProvider = const AssetImage("assets/img-user2.png");
      }

      return Scaffold(
        appBar: AppBar(
          title: const Text("My Photo"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: PhotoView(
          backgroundDecoration: const BoxDecoration(
            color: AppColors.kWhiteColor,
          ),
          imageProvider: selectedImageProvider,
          minScale: PhotoViewComputedScale.contained * 0.8,
          maxScale: PhotoViewComputedScale.covered * 2,
          initialScale: PhotoViewComputedScale.contained,
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return photoViewZoom();
              }));
            },
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.kGreyColor,
                image: user.photo.isEmpty
                    ? const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/img-user2.png"),
                      )
                    : DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(user.photo),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
