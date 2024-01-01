import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/components/custom_loading.dart';
import 'data/models/user_model.dart';
import 'data/services/firebase_user_service.dart';
import 'firebase_options.dart';
import 'presentation/auth/pages/login_page.dart';
import 'presentation/home/pages/dashboard_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Task Hub",
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: StreamBuilder<User?>(
        stream: _auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CustomLoading();
          } else if (snapshot.hasData) {
            return FutureBuilder<UserModel>(
              future: FirebaseUserService().getUserById(snapshot.data!.uid),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return const CustomLoading();
                } else if (userSnapshot.hasData) {
                  return DashboardPage(user: userSnapshot.data!);
                } else {
                  return const LoginPage();
                }
              },
            );
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
