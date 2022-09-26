import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
            color: Colors.black,
            textColor: Colors.white,
            height: 60.0,
            minWidth: 200.0,
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

      print("Google User");
      print(googleUser);

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      MySnackbar.showSnackbar(
          context: ctx,
          message: "Logged in successfully",
          type: SnakbarType.success);
      Navigator.of(ctx).pushNamed(HomeScreen.routeName);
    } catch (e) {
      print("error");
      MySnackbar.showSnackbar(
          context: ctx, message: "Unable to login!.", type: SnakbarType.error);
      print(e);
    }
  }
}
