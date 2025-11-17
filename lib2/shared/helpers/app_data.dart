import 'package:easy_localization/easy_localization.dart';
import 'package:taxiapp_mobile/network/models/common/status_type_model.dart';

import '../../core/dto/option.dart';
import '../../translations/locale_keys.g.dart';

final List<Option> monthList = [
  Option(value: "01", label: LocaleKeys.january.tr()),
  Option(value: "02", label: LocaleKeys.february.tr()),
  Option(value: "03", label: LocaleKeys.march.tr()),
  Option(value: "04", label: LocaleKeys.april.tr()),
  Option(value: "05", label: LocaleKeys.may.tr()),
  Option(value: "06", label: LocaleKeys.june.tr()),
  Option(value: "07", label: LocaleKeys.july.tr()),
  Option(value: "08", label: LocaleKeys.august.tr()),
  Option(value: "09", label: LocaleKeys.september.tr()),
  Option(value: "10", label: LocaleKeys.october.tr()),
  Option(value: "11", label: LocaleKeys.november.tr()),
  Option(value: "12", label: LocaleKeys.december.tr()),
];

const List<StatusTypes> statusTypes = [
  StatusTypes(
    id: '1',
    value: "PENDING",
    name: 'Pending',
  ),
  StatusTypes(value: "COMPLETED", id: '2', name: 'Completed'),
  StatusTypes(
    value: "WONT_DO",
    id: '3',
    name: 'Won\'t Do',
  ),
];

List<Option> get yearList {
  final currentYear = DateTime.now().year;

  final years = List.generate(
    currentYear - 2010 + 1,
    (index) {
      final String year = (2010 + (index)).toString();

      return Option(
        label: year,
        value: year,
      );
    },
  );

  return years.toList();
}

final payableMonthList = List.generate(3, (index) {
  final month = index + 1;
  final label = month == 1
      ? "1 ${LocaleKeys.month.tr()}"
      : "$month ${LocaleKeys.months.tr()}";

  return Option(value: month.toString(), label: label);
});
