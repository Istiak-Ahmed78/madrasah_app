import 'package:flutter_test/flutter_test.dart';
import 'package:madrasah_app/constants.dart';
import 'package:madrasah_app/utils/form_validation.dart';

void main() {
  group('Test validators', () {
    test('Validate email', () {
      String? data1 = FormValidation.validateEmail(null);
      String? data2 = FormValidation.validateEmail('aistiak6@gmail');

      expect(data1, 'Email adress is required');
      expect(data2, 'Enter valid email address');
    });

    test('Test password validation', () {
      String? _validatedResult = FormValidation.validatePassword(null);

      expect(_validatedResult, FormValidationErrorMessage.ematyFieldMessage);
    });
  });
}
