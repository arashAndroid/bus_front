import 'package:bus/UI/views/MainView.dart';
import 'package:bus/core/viewmodels/SplashViewModel.dart';
import 'package:bus/helpers/AnimationHandler.dart';
import 'package:bus/helpers/Constants.dart';
import 'package:bus/helpers/SharedPrefHelper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final introKey = GlobalKey<IntroductionScreenState>();
  SplashViewModel splashViewModel;

  @override
  void initState() {
    super.initState();
    splashViewModel = Provider.of<SplashViewModel>(context, listen: false);
    splashViewModel.initSplash(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SplashViewModel>(
        builder: (_, splashConsumer, __) => getPage(splashConsumer));
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('images/$assetName', width: width);
  }

  void _onIntroEnd(context) {
    setIsFirst().then((value) {
      Navigator.of(context).pushNamed('/LoginView');
    });
  }

  Widget introScreen() {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );
    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      pages: [
        PageViewModel(
          title: "اتوبوس در کل ایران",
          body:
              "هر کجای ایران که باشی و به هر کجای ایران که می‌ری با اتوبوس سریع اتوبوس بگیر",
          image: _buildImage('intro1.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "مسافر بین راهی",
          body: "مسافر بین راهی هستی، اتوبوس بگیر\n سریع، آسان و ارزان",
          image: _buildImage('intro2.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "امنیت و راحتی",
          body: "با خیال راحت با اوتوبوس سفر کن",
          image: _buildImage('intro3.png'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      //rtl: true, // Display as right-to-left
      skip: const Text(
        'رد کردن',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      color: colorRedorange,
      next: const Icon(Icons.arrow_forward),
      done: const Text('شروع', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: colorSeagray,
        activeColor: colorRedorange,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }

  Widget splashScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(64),
        child: AnimationHandler().popUp(
          const Image(
            image: AssetImage('images/icon.png'),
            height: 75,
          ),
          Curves.elasticOut,
          0,
        ),
      ),
    );
  }

  Widget getPage(SplashViewModel splashConsumer) {
    if (splashConsumer.isFirst) {
      return introScreen();
    } else {
      return splashScreen();
    }
  }
}
