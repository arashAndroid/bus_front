import 'package:bus/core/viewmodels/RegisterViewModel.dart';
import 'package:bus/helpers/Constants.dart';
import 'package:bus/helpers/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key key}) : super(key: key);
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  RegisterViewModel registerViewModel;

  @override
  void initState() {
    super.initState();
    registerViewModel = Provider.of<RegisterViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Background(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: const Text(
                  "ثبت‌نام",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: colorRedorange,
                      fontSize: 36),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: registerViewModel.usernameController,
                  decoration: const InputDecoration(labelText: "نام کاربری"),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: registerViewModel.emailController,
                  decoration: const InputDecoration(labelText: "ایمیل"),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: registerViewModel.passwordController,
                  decoration: const InputDecoration(labelText: "رمز ورود"),
                  obscureText: true,
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Consumer<RegisterViewModel>(
                builder: (_, registerConsumer, __) => Container(
                  alignment: Alignment.centerRight,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: RaisedButton(
                    onPressed: registerConsumer.isLoading
                        ? null
                        : () {
                            registerViewModel.signup(context);
                          },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(0),
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      width: size.width * 0.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80.0),
                          gradient: const LinearGradient(
                              colors: [colorRedorange, colorLightred])),
                      padding: const EdgeInsets.all(0),
                      child: registerConsumer.isLoading
                          ? const SpinKitThreeBounce(
                              color: Colors.white,
                              size: 20,
                            )
                          : const Text(
                              "ثبت‌نام",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: GestureDetector(
                  onTap: () => {Navigator.pushNamed(context, '/LoginView')},
                  child: const Text(
                    "قبلا ثبت‌نام کرده‌اید؟ وارد شوید",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: colorLightblue),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
