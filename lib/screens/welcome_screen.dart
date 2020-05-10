import 'package:flutter/material.dart';
import 'package:sallonfirebase/components/login_button.dart';

import 'login_screen.dart';
import 'register_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static String url = '/';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(
        seconds: 2,
      ),
      vsync: this,
    );
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var children2 = <Widget>[
      Row(
        children: <Widget>[
          Flexible(
                      child: Hero(
              tag: 'bounce',
              child: Container(
                child: Image.asset('images/logo.png'),
                height: 60.0,
              ),
            ),
          ),
          Text(
            'Flash Chat',
            style: TextStyle(
              fontSize: 45.0,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
      SizedBox(
        height: 48.0,
      ),
      LoginButton(
        colors: Colors.lightBlueAccent,
        ontap: () {
          Navigator.pushNamed(context, LoginScreen.url);
        },
        name: 'Login',
      ),
      LoginButton(
        colors: Colors.blueAccent,
        ontap: () {
          Navigator.pushNamed(context, RegistrationScreen.url);
        },
        name: 'Register',
      ),
    ];
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(controller.value),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children2,
        ),
      ),
    );
  }
}
