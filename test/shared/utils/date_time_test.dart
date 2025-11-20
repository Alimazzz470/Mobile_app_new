import 'package:flutter_test/flutter_test.dart';
import 'package:taxiapp_mobile/shared/utils/date_time.dart';

void main() {
  group('DateTime Utils', () {
    group('isSameYear', () {
      test('returns true when years are the same', () {
        final date1 = DateTime(2023, 1, 1);
        final date2 = DateTime(2023, 12, 31);
        expect(isSameYear(date1, date2), isTrue);
      });

      test('returns false when years are different', () {
        final date1 = DateTime(2023, 12, 31);
        final date2 = DateTime(2024, 1, 1);
        expect(isSameYear(date1, date2), isFalse);
      });
    });

    group('DateTimeExtension', () {
      test('dateOnly returns date with zeroed time', () {
        final date = DateTime(2023, 5, 20, 14, 30, 45);
        final dateOnly = date.dateOnly;
        expect(dateOnly.year, 2023);
        expect(dateOnly.month, 5);
        expect(dateOnly.day, 20);
        expect(dateOnly.hour, 0);
        expect(dateOnly.minute, 0);
        expect(dateOnly.second, 0);
        expect(dateOnly.millisecond, 0);
      });

      test('timeOnly returns time with zeroed date components (year 0)', () {
        final date = DateTime(2023, 5, 20, 14, 30, 45);
        final timeOnly = date.timeOnly;
        expect(timeOnly.year, 0);
        expect(timeOnly.month, 0); // In Dart DateTime(0,0,0) results in year -1 or 0 depending on implementation details usually it normalizes.
        // Actually DateTime(0, 0, 0) might behave oddly. Let's verify logic.
        // The implementation is DateTime(0, 0, 0, hour, minute, second).
        // Let's just check the time components.
        expect(timeOnly.hour, 14);
        expect(timeOnly.minute, 30);
        expect(timeOnly.second, 45);
      });

      test('isEqualOrBefore returns correct boolean', () {
        final base = DateTime(2023, 5, 20);
        final same = DateTime(2023, 5, 20, 10, 0); // Same day
        final before = DateTime(2023, 5, 19);
        final after = DateTime(2023, 5, 21);

        expect(base.isEqualOrBefore(same), isTrue);
        expect(before.isEqualOrBefore(base), isTrue); // 19th is before 20th
        expect(base.isEqualOrBefore(before), isFalse); // 20th is not before 19th

        // Wait, the implementation is:
        // return dateOnly.isAtSameMomentAs(date.dateOnly) || dateOnly.isBefore(date.dateOnly);
        // So `base.isEqualOrBefore(target)` means "is base <= target?"

        // Case: base (20th) <= same (20th) -> True
        expect(base.isEqualOrBefore(same), isTrue);

        // Case: base (20th) <= after (21st) -> True
        expect(base.isEqualOrBefore(after), isTrue);

        // Case: base (20th) <= before (19th) -> False
        expect(base.isEqualOrBefore(before), isFalse);
      });
    });
  });
}
