import 'package:bus/helpers/Constants.dart';
import 'package:flutter/material.dart';

class AboutUsViewModel with ChangeNotifier {
  final AuthServiceType authServiceType;
  AboutUsViewModel({this.authServiceType = AuthServiceType.real});

  String aboutUsText =
      """اپلیکیشن اتوبوس در سال 1400 راه‌اندازی شد. اتوبوس تلاشی است برای ایجاد سهولت و امنیت در سفرهای برون شهری. شما می‌تونید با اپلیکیشن اوتوبس در کمترین زمان بلیط تهیه بکنید. ناوگان اتوبوس تشکیل شده از وسایل نقلیه مدرن و رانندگان با اطمینان، تضمین یک سفر امن و سریع رو به شما می‌دهد.""";
}
