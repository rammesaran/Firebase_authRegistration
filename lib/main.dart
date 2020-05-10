
import 'package:flutter/material.dart';


import 'screens/chat_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/welcome_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Flash Chat',
      theme: ThemeData().copyWith(
        textTheme: TextTheme(
          body1: TextStyle(
            color: Colors.black,
          ),
        ),
        
      ),
      initialRoute: '/',
      routes: {
        WelcomeScreen.url : (context) => WelcomeScreen(),
        LoginScreen.url : (context) => LoginScreen(),
        RegistrationScreen.url : (context) => RegistrationScreen(),
        ChatScreen.url : (context) => ChatScreen(),
      },
    );
  }
}
