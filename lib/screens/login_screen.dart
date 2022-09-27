import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:udhari/models/Auth.dart';
import 'package:udhari/screens/home_screen.dart';
import 'package:udhari/widgets/my_snackbar.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static const String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text(
                'choton',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text(
                'A simple way to manage your expenses',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: 60),
          MaterialButton(
            onPressed: () => _loginWithGoogle(context),
            color: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 0.0,
            child: const Text('Login with Google'),
          )
        ],
      ),
    ));
  }

  // Handle the login with Google button press
  _loginWithGoogle(BuildContext ctx) async {
    try {
      MySnackbar.showSnackbar(
          context: ctx, message: "Login with Google", type: SnakbarType.info);

      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      AuthUser u = AuthUser.fromGoogleSignIn(googleUser!);

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);

      Get.snackbar("Logged in successfully", "Logged in successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
      Get.offAndToNamed(HomeScreen.routeName, arguments: u);
    } catch (e) {
      print("error");
      MySnackbar.showSnackbar(
          context: ctx, message: "Unable to login!.", type: SnakbarType.error);
      print(e);
    }
  }
}
