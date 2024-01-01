import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_hub/data/models/user_model.dart';

class FirebaseUserService {
  final CollectionReference _userReference =
      FirebaseFirestore.instance.collection("users");

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

      UserModel user = UserModel(
        id: userId,
        name: snapshot["name"],
        email: snapshot["email"],
        role: snapshot["role"],
        photo: snapshot["photo"],
      );

      return user;
    } catch (e) {
      rethrow;
    }
  }
}
