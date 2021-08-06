import 'package:bus/helpers/SharedPrefHelper.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({Key key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
          icon: const Icon(Icons.exit_to_app),
          onPressed: () {
            setLoggedOut().then((value) {
              Navigator.of(context).pushNamed('/LoginView');
            });
          },
        ),
      ),
    );
  }
}
