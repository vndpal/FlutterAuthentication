import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

FirebaseAuth auth = FirebaseAuth.instance;

final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

final _formKey = GlobalKey<FormState>();

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: "Email",
                  icon: Icon(Icons.email_outlined),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  hintText: "Password",
                  icon: Icon(Icons.password_outlined),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton.icon(
                onPressed: () {},
                label: const Text(
                  "Sign In",
                ),
                icon: const Icon(Icons.login_outlined),
              ),
              const SizedBox(
                height: 10,
              ),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add_circle_outline_outlined),
                label: const Text("Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
