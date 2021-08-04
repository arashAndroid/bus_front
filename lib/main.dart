import './core/viewmodels/LoginViewModel.dart';
import './core/viewmodels/SplashViewModel.dart';
import './helpers/SharedPrefHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import 'UI/views/LoginView.dart';
import 'UI/views/MainView.dart';
import 'UI/views/SplashView.dart';
import 'core/viewmodels/MainViewModel.dart';
import 'helpers/Constants.dart';

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
