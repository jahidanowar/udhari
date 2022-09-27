import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  RxBool isLoggedIn = false.obs;
  late Rx<User?> firebaseUser;
  late Rx<GoogleSignInAccount?> googleSignInAccount;

  // @override
  // void onInit() {
  //   firebaseUser = Rx<User?>(auth.currentUser);
  //   googleSignInAccount = Rx<GoogleSignInAccount?>(googleSignIn.currentUser);
  //   ever(firebaseUser, handleAuthChanged);
  //   super.onInit();
  // }

}
