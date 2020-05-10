import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sallonfirebase/components/login_button.dart';
import 'package:sallonfirebase/screens/chat_screen.dart';

import '../constant.dart';

class LoginScreen extends StatefulWidget {
  static String url = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;
  final _auth = FirebaseAuth.instance;
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      body: ModalProgressHUD(
        inAsyncCall: isloading,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                              child: Hero(
                  tag: 'bounce',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                  onChanged: (value) {
                    email = value.trim();
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: "Enter your email",
                  )),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  onChanged: (value) {
                    password = value.trim();
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter Password',
                  )),
              SizedBox(
                height: 24.0,
              ),
              LoginButton(
                  colors: Colors.white,
                  name: "Login",
                  
                  ontap: () async {
                    setState(() {
                      isloading = true;
                    });
                    AuthResult result = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (result != null) {
                      Navigator.pushNamed(context, ChatScreen.url);
                      setState(() {
                        isloading = false;
                      });
                    } else {
                      print('error');
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
