import 'package:flutter_test/flutter_test.dart';
import 'package:madrasah_app/utils/form_validation.dart';

void main() {
  test('Test validation', () {
    expect('Email adress is required', FormValidation.validateEmail(null));
  });
}
