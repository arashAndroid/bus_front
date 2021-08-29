import 'package:bus/UI/widgets/QuarterCircle.dart';
import 'package:bus/core/viewmodels/AboutUsViewModel.dart';
import 'package:bus/helpers/Constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AboutUsView extends StatelessWidget {
  const AboutUsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AboutUsViewModel aboutUsViewModel =
        Provider.of<AboutUsViewModel>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            key: const Key('mainAppBar'),
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              'درباره ما',
              style: TextStyle(
                color: colorTextPrimary,
                fontSize: fontSizeTitle + 2,
                fontWeight: FontWeight.bold,
              ),
            ),
            iconTheme: const IconThemeData(color: colorTextPrimary),
          ),
          body: Stack(
            children: [
              const Align(
                alignment: Alignment.bottomLeft,
                child: Hero(
                  tag: "bottomBig",
                  child: SizedBox(
                    height: 250,
                    width: 250,
                    child: QuarterCircle(
                      circleAlignment: QuarterCircleAlignment.bottomLeft,
                    ),
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.bottomLeft,
                child: Hero(
                  tag: "bottomSmall",
                  child: SizedBox(
                    height: 125,
                    width: 125,
                    child: QuarterCircle(
                      circleAlignment: QuarterCircleAlignment.bottomLeft,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  constraints: kIsWeb
                      ? BoxConstraints(maxWidth: size.width / 2)
                      : const BoxConstraints(),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            top: 8, right: 8, left: 8, bottom: 16),
                        child: const Image(
                            image: AssetImage('images/about.png'), height: 150),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Text(
                          aboutUsViewModel.aboutUsText,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            color: colorTextPrimary,
                            fontSize: fontSizeSubTitle,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
