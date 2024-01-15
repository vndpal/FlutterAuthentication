import 'package:flutter/material.dart';
import 'package:myflutterapp/login_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter App',
      home: LoginScreen(),
    );
  }
}
