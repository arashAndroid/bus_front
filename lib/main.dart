import 'package:bus/UI/views/RegisterView.dart';
import 'package:bus/core/viewmodels/ResultViewModel.dart';

import 'package:bus/core/viewmodels/LoginViewModel.dart';
import 'package:bus/core/viewmodels/SplashViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import 'package:bus/UI/views/LoginView.dart';
import 'package:bus/UI/views/MainView.dart';
import 'package:bus/UI/views/ResultView.dart';
import 'package:bus/UI/views/SplashView.dart';
import 'package:bus/core/viewmodels/MainViewModel.dart';
import 'package:bus/core/viewmodels/RegisterViewModel.dart';
import 'package:bus/helpers/Constants.dart';

void main() => runApp(
      const MyApp(initialAuthServiceType: AuthServiceType.real),
    );

class MyApp extends StatelessWidget {
  const MyApp({Key key, this.initialAuthServiceType = AuthServiceType.real})
      : super(key: key);
  final AuthServiceType initialAuthServiceType;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) =>
                  MainViewModel(authServiceType: initialAuthServiceType)),
          ChangeNotifierProvider(
              create: (context) =>
                  LoginViewModel(authServiceType: initialAuthServiceType)),
          ChangeNotifierProvider(
              create: (context) =>
                  SplashViewModel(authServiceType: initialAuthServiceType)),
          ChangeNotifierProvider(
              create: (context) =>
                  RegisterViewModel(authServiceType: initialAuthServiceType)),
          ChangeNotifierProvider(
              create: (context) =>
                  ResultViewModel(authServiceType: initialAuthServiceType)),
        ],
        child: MaterialApp(
          theme: ThemeData(
            fontFamily: 'Sans',
            canvasColor: Colors.white,
          ),
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case '/MainView':
                return MaterialPageRoute(
                    builder: (context) => const MainView());
              case '/LoginView':
                return MaterialPageRoute(
                    builder: (context) => const LoginView());
              case '/RegisterView':
                return MaterialPageRoute(
                    builder: (context) => const RegisterView());
              case '/ResultView':
                return MaterialPageRoute(
                    builder: (context) => const ResultView());
              default:
                return MaterialPageRoute(
                    builder: (context) => const MainView());
            }
          },
          home: const SplashView(),
          builder: EasyLoading.init(),
        ));
  }
}
