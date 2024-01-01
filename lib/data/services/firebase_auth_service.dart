import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_hub/data/models/user_model.dart';
import 'package:task_hub/data/services/firebase_user_service.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel user =
          await FirebaseUserService().getUserById(userCredential.user!.uid);

      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    required String role,
    required String photo,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel user = UserModel(
        id: userCredential.user!.uid,
        name: name,
        email: email,
        photo: photo,
        role: role,
      );

      await FirebaseUserService().setUser(user);

      return user;
    } catch (e) {
      rethrow;
    }
  }
}
