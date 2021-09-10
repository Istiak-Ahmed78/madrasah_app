import 'package:firebase_auth/firebase_auth.dart';

class AuthResponce {
  final String? errorMessage;
  final UserCredential? userCredential;

  AuthResponce({this.errorMessage, this.userCredential});
  AuthResponce.withCredential(UserCredential userCredential)
      : userCredential = userCredential,
        errorMessage = null;
  AuthResponce.withErorr(String errorMesage)
      : errorMessage = errorMesage,
        userCredential = null;
}
