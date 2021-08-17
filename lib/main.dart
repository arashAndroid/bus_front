import 'package:bus/UI/views/MyTicketDetailView.dart';
import 'package:bus/UI/views/MyTicketsView.dart';
import 'package:bus/UI/views/RegisterView.dart';
import 'package:bus/core/viewmodels/MyTicketDetailViewModel.dart';
import 'package:bus/core/viewmodels/MyTicketsViewModel.dart';
import 'package:bus/core/viewmodels/ResultViewModel.dart';

import 'package:bus/core/viewmodels/LoginViewModel.dart';
import 'package:bus/core/viewmodels/SplashViewModel.dart';
import 'package:bus/core/viewmodels/TicketViewModel.dart';
import 'package:bus/core/viewmodels/TravelViewModel.dart';
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

import 'UI/views/TicketView.dart';
import 'UI/views/TravelView.dart';

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
          ChangeNotifierProvider(
              create: (context) =>
                  TravelViewModel(authServiceType: initialAuthServiceType)),
          ChangeNotifierProvider(
              create: (context) =>
                  TicketViewModel(authServiceType: initialAuthServiceType)),
          ChangeNotifierProvider(
              create: (context) =>
                  MyTicketsViewModel(authServiceType: initialAuthServiceType)),
          ChangeNotifierProvider(
              create: (context) => MyTicketDetailViewModel(
                  authServiceType: initialAuthServiceType)),
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
              case '/TravelView':
                return MaterialPageRoute(
                    builder: (context) => const TravelView());
              case '/TicketView':
                return MaterialPageRoute(
                    builder: (context) => const TicketView());
              case '/MyTicketsView':
                return MaterialPageRoute(
                    builder: (context) => const MyTicketsView());
              case '/MyTicketDetailView':
                return MaterialPageRoute(
                    builder: (context) => const MyTicketDetailView());
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
