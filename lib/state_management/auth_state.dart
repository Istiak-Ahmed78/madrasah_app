// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:madrasah_app/di_contailer.dart';
// import 'package:madrasah_app/models/auth_respoce_model.dart';
// import 'package:madrasah_app/utils/auth_repos/auth_repos.dart';
// import 'package:madrasah_app/utils/firestore_repos/firestore_repos.dart';
// import '../constants.dart';

// class AuthState extends ChangeNotifier {
//   final AuthRepos authRepos;
//   AuthState(this.authRepos);

//   User? currentUserLocal;
//   String firebaseLocalErrorMessage = '';
//   bool isLoadingLocal = false;
//   bool isAdminLocal = false;

//   User? get currentuser => currentUserLocal;
//   String get firebaseErrorMessgase => firebaseLocalErrorMessage;
//   bool get isLoading => isLoadingLocal;
//   bool get isAdmin => isAdminLocal;
//   User? get getCurrentUser => authRepos.getCurrentUser();
// }
