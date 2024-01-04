import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:task_hub/data/models/user_model.dart';

class FirebaseUserService {
  final CollectionReference _userReference =
      FirebaseFirestore.instance.collection("users");

  Future<String> uploadImgToFirebase(File imageFile) async {
    try {
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child("user-image")
          .child("${DateTime.now().toString()}.png");

      await ref.putFile(imageFile);
      String imageUrl = await ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setUser(UserModel user) async {
    try {
      _userReference.doc(user.id).set({
        "name": user.name,
        "email": user.email,
        "photo": user.photo,
        "role": user.role,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> getUserById(String userId) async {
    try {
      DocumentSnapshot snapshot = await _userReference.doc(userId).get();

      if (snapshot.exists) {
        UserModel user = UserModel(
          id: userId,
          name: snapshot["name"],
          email: snapshot["email"],
          role: snapshot["role"],
          photo: snapshot["photo"],
        );

        return user;
      } else {
        throw Exception("User data not found!");
      }
    } catch (e) {
      throw Exception("Error fetching user data: $e");
    }
  }
}
