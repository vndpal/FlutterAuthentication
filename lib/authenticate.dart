import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myflutterapp/secure_storage.dart';

class Authentication {
  static Future<bool> isOnline() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  static Future<AuthResponse?> authenticate(
      String email, String password) async {
    if (await isOnline()) {
      // Online authentication with Firebase
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        return AuthResponse(
            username: email,
            userDetails: userCredential.user,
            isAuthenticated: true,
            message: "Login Success");
      } on FirebaseAuthException catch (e) {
        // Handle authentication errors
        print("Error: ${e.message}");
        return AuthResponse(
            username: email, isAuthenticated: false, message: e.message!);
      }
    } else {
      String? securedUsername = await SecureStorage().getUserName();
      String? securedPasswoed = await SecureStorage().getPassWord();
      if (securedPasswoed == password && securedUsername == email) {
        return AuthResponse(
            username: email,
            isAuthenticated: true,
            message: "Logged in successfully");
      } else {
        return AuthResponse(
            username: email,
            isAuthenticated: false,
            message:
                "Incorrect credentials! you may reset the password after you are online!");
      }
    }
  }
}

class AuthResponse {
  final String username;
  final User? userDetails;
  final bool isAuthenticated;
  final String message;

  AuthResponse(
      {required this.username,
      this.userDetails,
      required this.isAuthenticated,
      required this.message});
}
