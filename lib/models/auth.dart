import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthUser {
  final String id;
  final String? name;
  final String email;
  final String? photoURL;

  AuthUser({
    required this.id,
    required this.name,
    required this.email,
    this.photoURL,
  });

  factory AuthUser.fromFirebase(UserCredential userCredential) {
    return AuthUser(
      id: userCredential.user!.uid,
      name: userCredential.user!.displayName,
      email: userCredential.user!.email!,
      photoURL: userCredential.user!.photoURL,
    );
  }

  factory AuthUser.fromGoogleSignIn(GoogleSignInAccount googleUser) {
    return AuthUser(
      id: googleUser.id,
      name: googleUser.displayName,
      email: googleUser.email,
      photoURL: googleUser.photoUrl,
    );
  }
}
