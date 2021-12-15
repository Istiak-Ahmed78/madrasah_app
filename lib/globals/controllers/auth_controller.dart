import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:madrasah_app/constants.dart';
import 'package:madrasah_app/models/auth_respoce_model.dart';
import 'package:madrasah_app/utils/auth_repos/auth_repos.dart';

class AuthController extends GetxController {
  AuthController() {}

  bool isLoading = true;
  User? currentUserLocal;
  String firebaseLocalErrorMessage = '';
  bool isLoadingLocal = false;
  bool isAdminLocal = false;
  RxBool isLoggedIn = false.obs;

  AuthRepos authRepos = AuthRepos();

  Future<bool> getAdminStatus(emailAddressToCheck) async {
    final adminRecords = [];
    if (adminRecords.isEmpty)
      return false;
    else {
      bool check = false;
      for (var i in adminRecords) {
        check = i.id == emailAddressToCheck;
      }
      isAdminLocal = check;
      update();
      return check;
    }
  }

  Future<bool> logInwithEmailAndPassword(String email, String password) async {
    isLoadingLocal = true;
    firebaseLocalErrorMessage = '';
    update();
    AuthResponce authRespoce =
        await authRepos.logInWithEmailAndPassword(email, password);
    if (authRespoce.userCredential != null) {
      currentUserLocal = authRespoce.userCredential!.user;
      if (await getAdminStatus(currentUserLocal!.email)) {
        isAdminLocal = true;
      }
      isLoadingLocal = false;
      update();
      return true;
    } else {
      firebaseLocalErrorMessage =
          authRespoce.errorMessage ?? FirebaseErrorMessages.defaultErrorMessage;
      isLoadingLocal = false;
      update();
      return false;
    }
  }

  Future<void> signInWithGoogle() async {
    isLoadingLocal = true;
    update();
    AuthResponce _authRespoce = await authRepos.signInWithGooglleAccount();
    if (_authRespoce.userCredential != null) {
      currentUserLocal = _authRespoce.userCredential!.user;
      isLoadingLocal = false;
      update();
    } else {
      firebaseLocalErrorMessage = _authRespoce.errorMessage ?? '';
      isLoadingLocal = false;
      update();
    }
  }

  Future<void> singnInWithFacebook() async {
    isLoadingLocal = true;
    update();
    AuthResponce _authRespoce = await authRepos.signInWithFacebook();
    if (_authRespoce.userCredential != null) {
      currentUserLocal = _authRespoce.userCredential!.user;
      isLoadingLocal = false;
      update();
    } else {
      firebaseLocalErrorMessage = _authRespoce.errorMessage ??
          FirebaseErrorMessages.defaultErrorMessage;
      isLoadingLocal = false;
      update();
    }
  }

  Future<void> sendVerificationEmail(User user) =>
      authRepos.sendEmailVerificationLink(user);

  Future<bool> sendForgetPasswordMail(email) async {
    try {
      await authRepos.sendForgetPassEmail(email);
      return true;
    } on FirebaseException catch (e) {
      firebaseLocalErrorMessage =
          e.message ?? FirebaseErrorMessages.defaultErrorMessage;
      update();
      return false;
    }
  }

  Future<bool> createUser(String email, String password) async {
    isLoadingLocal = true;
    update();
    AuthResponce authRespoce = await authRepos.createNewUser(email, password);
    if (authRespoce.userCredential != null) {
      currentUserLocal = authRespoce.userCredential!.user;
      isLoadingLocal = false;
      update();
      return true;
    } else {
      firebaseLocalErrorMessage =
          authRespoce.errorMessage ?? FirebaseErrorMessages.defaultErrorMessage;
      isLoadingLocal = false;
      update();
      return false;
    }
  }

  Future<void> logOut() async {
    await authRepos.logout();
    currentUserLocal = null;
    update();
  }
}
