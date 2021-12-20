import 'package:flutter_test/flutter_test.dart';

void main() {
  final calculator = Calculator();
  int data = calculator.add(5, 2);
  test('Testing addintion', () {
    expect(data, 4);
  });
}

class Calculator {
  add(int a, b) => a + b;
}
