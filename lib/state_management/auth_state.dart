import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:madrasah_app/di_contailer.dart';
import 'package:madrasah_app/models/auth_respoce_model.dart';
import 'package:madrasah_app/utils/auth_repos/auth_repos.dart';
import 'package:madrasah_app/utils/firestore_repos/firestore_repos.dart';
import '../constants.dart';

class AuthState extends ChangeNotifier {
  final AuthRepos authRepos;
  AuthState(this.authRepos);

  User? currentUserLocal;
  String firebaseLocalErrorMessage = '';
  bool isLoadingLocal = false;
  bool isAdminLocal = false;

  User? get currentuser => currentUserLocal;
  String get firebaseErrorMessgase => firebaseLocalErrorMessage;
  bool get isLoading => isLoadingLocal;
  bool get isAdmin => isAdminLocal;
  User? get getCurrentUser => authRepos.getCurrentUser();

  Future<bool> logInwithEmailAndPassword(String email, String password) async {
    isLoadingLocal = true;
    firebaseLocalErrorMessage = '';
    notifyListeners();
    AuthResponce authRespoce =
        await authRepos.logInWithEmailAndPassword(email, password);
    if (authRespoce.userCredential != null) {
      currentUserLocal = authRespoce.userCredential!.user;
      if (await getAdminStatus(currentUserLocal!.email)) {
        isAdminLocal = true;
      }
      isLoadingLocal = false;
      notifyListeners();
      return true;
    } else {
      firebaseLocalErrorMessage =
          authRespoce.errorMessage ?? FirebaseErrorMessages.defaultErrorMessage;
      isLoadingLocal = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> getAdminStatus(emailAddressToCheck) async {
    final adminRecords =
        (await services<FirestoreRepos>().getAdminRecords()).docs;
    if (adminRecords.isEmpty)
      return false;
    else {
      bool check = false;
      for (var i in adminRecords) {
        check = i.id == emailAddressToCheck;
      }
      isAdminLocal = check;
      notifyListeners();
      return check;
    }
  }

  bool isLoggedIn() => authRepos.getCurrentUser() != null;
  bool isEmailVarified(User user) => authRepos.isEmailVarified(user);

  Future<void> sendVerificationEmail(User user) =>
      authRepos.sendEmailVerificationLink(user);

  Future<bool> sendForgetPasswordMail(email) async {
    try {
      await authRepos.sendForgetPassEmail(email);
      return true;
    } on FirebaseException catch (e) {
      firebaseLocalErrorMessage =
          e.message ?? FirebaseErrorMessages.defaultErrorMessage;
      notifyListeners();
      return false;
    }
  }

  Future<bool> createUser(String email, String password) async {
    isLoadingLocal = true;
    notifyListeners();
    AuthResponce authRespoce = await authRepos.createNewUser(email, password);
    if (authRespoce.userCredential != null) {
      currentUserLocal = authRespoce.userCredential!.user;
      isLoadingLocal = false;
      notifyListeners();
      return true;
    } else {
      firebaseLocalErrorMessage =
          authRespoce.errorMessage ?? FirebaseErrorMessages.defaultErrorMessage;
      isLoadingLocal = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> signInWithGoogle() async {
    isLoadingLocal = true;
    notifyListeners();
    AuthResponce _authRespoce = await authRepos.signInWithGooglleAccount();
    if (_authRespoce.userCredential != null) {
      currentUserLocal = _authRespoce.userCredential!.user;
      isLoadingLocal = false;
      notifyListeners();
    } else {
      firebaseLocalErrorMessage = _authRespoce.errorMessage ?? '';
      isLoadingLocal = false;
      notifyListeners();
    }
  }

  Future<void> singnInWithFacebook() async {
    isLoadingLocal = true;
    notifyListeners();
    AuthResponce _authRespoce = await authRepos.signInWithFacebook();
    if (_authRespoce.userCredential != null) {
      currentUserLocal = _authRespoce.userCredential!.user;
      isLoadingLocal = false;
      notifyListeners();
    } else {
      firebaseLocalErrorMessage = _authRespoce.errorMessage ??
          FirebaseErrorMessages.defaultErrorMessage;
      isLoadingLocal = false;
      notifyListeners();
    }
  }

  Future<void> logOut() async {
    await authRepos.logout();
    currentUserLocal = null;
    notifyListeners();
  }
}
