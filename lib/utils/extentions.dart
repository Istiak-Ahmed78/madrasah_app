import 'package:firebase_auth/firebase_auth.dart';

extension NummValidation on User? {
  bool isNull() => this == null;
}
