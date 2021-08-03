import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:madrasah_app/models/auth_respoce_model.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../../constants.dart';

class AuthRepos {
  AuthRepos() {
    authInstance = FirebaseAuth.instance;
  }
  late FirebaseAuth authInstance;

  Future<AuthResponce> logInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential? authCredential;
      authCredential = await authInstance.signInWithEmailAndPassword(
          email: email, password: password);
      return AuthResponce.withCredential(authCredential);
    } on FirebaseAuthException catch (e) {
      return AuthResponce.withErorr(
          e.message ?? FirebaseErrorMessages.defaultErrorMessage);
    }
  }

  Future<AuthResponce> createNewUser(String email, String password) async {
    try {
      UserCredential _userCrecential = await authInstance
          .createUserWithEmailAndPassword(email: email, password: password);
      return AuthResponce.withCredential(_userCrecential);
    } on FirebaseException catch (error) {
      return AuthResponce.withErorr(
          error.message ?? FirebaseErrorMessages.defaultErrorMessage);
    }
  }

  Future<void> logout() => authInstance.signOut();

  User? getCurrentUser() {
    return authInstance.currentUser;
  }

  bool isEmailVarified(User user) => user.emailVerified;
  String get userId => getCurrentUser()!.uid;

  Future<void> sendEmailVerificationLink(User user) =>
      user.sendEmailVerification();

  Future<void> sendForgetPassEmail(email) =>
      authInstance.sendPasswordResetEmail(email: email);

  Future<AuthResponce> signInWithGooglleAccount() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();

      GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;

      final credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication?.idToken,
          accessToken: googleSignInAuthentication?.accessToken);

      return AuthResponce.withCredential(
          await authInstance.signInWithCredential(credential));
    } on FirebaseException catch (error) {
      return AuthResponce.withErorr(
          error.message ?? FirebaseErrorMessages.defaultErrorMessage);
    }
  }

  Future<AuthResponce> signInWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final result = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final facebookAuthCredential =
          FacebookAuthProvider.credential(result.accessToken!.token);

      // Once signed in, return the UserCredential
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
      return AuthResponce.withCredential(userCredential);
    } on FirebaseAuthException catch (error) {
      print('Facebook login error');
      return AuthResponce.withErorr(
          error.message ?? FirebaseErrorMessages.defaultErrorMessage);
    }
  }
}
