import 'package:flutter/material.dart';
import '../../helpers/Constants.dart';
import '../../helpers/SharedPrefHelper.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ExitDialog extends Dialog {
  @override
  Widget build(BuildContext context) {
    {
      print("tapped");
    }

    Size size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      backgroundColor: colorTextWhite,
      child: Container(
        constraints: kIsWeb
            ? BoxConstraints(maxWidth: size.width / 3)
            : const BoxConstraints(),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  'آیا از خروج برنامه مطمئن هستید؟',
                  style: TextStyle(
                      color: colorTextPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: fontSizeTitle),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                MaterialButton(
                  onPressed: () => setLoggedOut().then((value) =>
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/LoginView', (route) => false)),
                  key: const Key('exitBtn'),
                  child: const Text(
                    'خروج',
                    style: TextStyle(
                        color: colorTextWhite, fontWeight: FontWeight.bold),
                  ),
                  disabledColor: colorPrimary,
                  color: colorDanger,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                SizedBox(width: 4),
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'انصراف',
                    style: TextStyle(color: colorTextPrimary),
                  ),
                  disabledColor: colorTextWhite,
                  elevation: 1,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
