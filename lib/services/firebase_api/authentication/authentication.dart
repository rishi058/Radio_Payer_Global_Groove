import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:global_groove/services/local_storage/get_storage_helper.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  static Future<bool> signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      try {
        final UserCredential userCredential =
            await auth.signInWithPopup(authProvider);

        user = userCredential.user;
      } catch (e) {
        Get.snackbar('Error while Sign In', e.toString());
      }
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount? googleSignInAccount;

      try {
        googleSignInAccount = await googleSignIn.signIn();
      } on PlatformException catch (e) {
        Get.snackbar('Error while Sign In', e.toString());
        return false;
      }

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential =
              await auth.signInWithCredential(credential);

          user = userCredential.user;
        } catch (e) {
          Get.snackbar('Error while Sign In', e.toString());
        }
      }
    }

    if (user != null) {
      LocalStorage().setLoginTrue();
      return true;
    }
    return false;
  }

  static Future<void> signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
      LocalStorage().setLoginFalse();
    } catch (e) {
      Get.snackbar('Error while Sign Out', e.toString());
    }
  }

  static Future<void> switchAccounts(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
    } catch (e) {
      Get.snackbar('Error while Sign Out', e.toString());
      return;
    }

    signInWithGoogle().then((value) async {
      if (value == false) {
        await googleSignIn.signInSilently();
      }
    });
  }
}
