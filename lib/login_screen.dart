// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myflutterapp/authenticate.dart';
import 'package:myflutterapp/home.dart';
import 'package:myflutterapp/secure_storage.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final SecureStorage _secureStorage = SecureStorage();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Flutter App'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.blueGrey,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () async {
                  String email = emailController.text;
                  String password = passwordController.text;
                  try {
                    AuthResponse? user =
                        await Authentication.authenticate(email, password);

                    if (user != null && user.isAuthenticated) {
                      await _secureStorage.setUserName(email);
                      await _secureStorage.setPassWord(password);

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyHomePage(
                            title: "My Flutter App",
                          ),
                        ),
                      );
                    } else {
                      SnackBar snackBara = SnackBar(
                        content: Text(
                          user!.message,
                          style: const TextStyle(fontSize: 16),
                        ),
                        backgroundColor: Colors.red,
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBara);
                    }
                  } on FirebaseAuthException catch (e) {
                    print("Error: ${e.message}");
                    const snackBar = SnackBar(
                      content: Text(
                        'Authentication failed. Please check your credentials.',
                        style: TextStyle(fontSize: 16),
                      ),
                      backgroundColor: Colors.red,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
