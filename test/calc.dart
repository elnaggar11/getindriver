import 'package:flutter_test/flutter_test.dart';

import 'calculate.dart';

  
void main() {
  group('Calculator Unit Tests', () {
    final calculator = Calculator();

    test('Addition works', () {
      expect(calculator.add(1, 1), 2);
    });

    test('Subtraction works', () {
      expect(calculator.subtract(1, 1), 0);
    });

    test('Multiplication works', () {
      expect(calculator.multiply(1, 1), 1);
    });

    test('Division works', () {
      expect(calculator.divide(1, 1), 1.0);
      expect(calculator.divide(1, 0), ArgumentError('Cannot divide by zero'));
    });

    test('Division by zero throws ArgumentError', () {
      expect(() => calculator.divide(1, 0), throwsArgumentError);
    });
  });
}
