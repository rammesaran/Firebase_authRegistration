import 'package:flutter/material.dart';
import 'package:sallonfirebase/components/login_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../constant.dart';
import 'chat_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static String url = '/register';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email;
  String password;
  final _auth = FirebaseAuth.instance;
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
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
                    hintText: 'Enter UserName',
                  )),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  obscureText: true,
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
                  colors: Colors.black,
                  name: 'Register',
                  ontap: () async {
                    setState(() {
                      isloading = true;
                    });
                    AuthResult result =
                        await _auth.createUserWithEmailAndPassword(
                            email: email, password: password);

                    if (result != null) {
                     Navigator.pushNamed(context, ChatScreen.url);
                     setState(() {
                       isloading = false;
                     });
                    } else {
                      print(Exception);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
