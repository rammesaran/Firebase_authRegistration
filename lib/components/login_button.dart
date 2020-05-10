import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
final Color colors;
final Function ontap;
final String name;
LoginButton({@required this.colors,@required this.name,@required this.ontap});

  @override
  Widget build(BuildContext context) {
    return  Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: colors,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: ontap,
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    name,
                  ),
                ),
              ),
            );
  }
}