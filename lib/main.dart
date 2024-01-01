import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_hub/presentation/auth/pages/login_page.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Task Hub",
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}
