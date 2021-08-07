import 'package:shamsi_date/shamsi_date.dart';

import 'package:persian_datepicker/persian_datepicker.dart';
import 'package:jalali_calendar/jalali_calendar.dart';

String convertTojalali(String dateTimeGregorian) {
  // print('caonverted dateTimeGregorian date = $dateTimeGregorian');

  var convertedNumber = convertNumbers(dateTimeGregorian);
  var dateGregorian = dateTimeGregorian.substring(0, 10).split('-');

  Gregorian g = Gregorian(int.parse(dateGregorian[0]),
      int.parse(dateGregorian[1]), int.parse(dateGregorian[2]));

  Jalali g2j1 = g.toJalali();

  var jalaliDate = '${g2j1.year}/${g2j1.month}/${g2j1.day}';

  return jalaliDate;
}

String convertNumbers(String str) {
  str = str.replaceAll('۱', '1');
  str = str.replaceAll('۲', '2');
  str = str.replaceAll('۳', '3');
  str = str.replaceAll('۴', '4');
  str = str.replaceAll('۵', '5');
  str = str.replaceAll('۶', '6');
  str = str.replaceAll('۷', '7');
  str = str.replaceAll('۸', '8');
  str = str.replaceAll('۹', '9');
  str = str.replaceAll('۰', '0');
  return str;
}

String getShamsiDate(String date) {
  if (date == null || date == '' || date == '0' || date == '0000-00-00')
    return '';
  print(date);
  PersianDate persianDate = PersianDate();
  // print('--------------------->');
  // print('persianDate is = ${persianDate.getNow.toString()}');
  var tempDate = date.split('-');

  var tempp = persianDate
      // .gregorianToJalali("${date}T00:19:54.000Z")
      .gregorianToJalali(int.parse(tempDate[0]), int.parse(tempDate[1]),
          int.parse(tempDate[2]), '-')
      .toString();
  // .substring(0, 10);
  // print('persianDate is converted = $tempp');

  return tempp;
}
