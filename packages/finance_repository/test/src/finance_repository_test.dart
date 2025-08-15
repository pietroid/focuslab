// ignore_for_file: prefer_const_constructors

import 'package:finance_repository/finance_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FinanceRepository', () {
    test('can be instantiated', () {
      expect(FinanceRepository(), isNotNull);
    });
  });
}
