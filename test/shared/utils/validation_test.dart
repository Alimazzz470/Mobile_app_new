import 'package:flutter_test/flutter_test.dart';
import 'package:taxiapp_mobile/shared/utils/validation.dart';

void main() {
  group('Validation Utils', () {
    test('isEmailValid returns true for valid emails', () {
      expect(isEmailValid('test@example.com'), isTrue);
      expect(isEmailValid('user.name@domain.co.uk'), isTrue);
      expect(isEmailValid('user+tag@example.com'), isTrue);
    });

    test('isEmailValid returns false for invalid emails', () {
      expect(isEmailValid('plainaddress'), isFalse);
      expect(isEmailValid('#@%^%#$@#$@#.com'), isFalse);
      expect(isEmailValid('@example.com'), isFalse);
      expect(isEmailValid('Joe Smith <email@example.com>'), isFalse);
      expect(isEmailValid('email.example.com'), isFalse);
      expect(isEmailValid('email@example@example.com'), isFalse);
    });
  });
}
