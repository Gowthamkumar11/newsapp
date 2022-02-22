import 'package:flutter/material.dart';
import 'package:news_app/google.dart';
import 'package:provider/provider.dart';

class GoogleSignupButtonWidget extends StatefulWidget {
  @override
  _GoogleSignupButtonWidgetState createState() =>
      _GoogleSignupButtonWidgetState();
}

class _GoogleSignupButtonWidgetState extends State<GoogleSignupButtonWidget> {
  @override
  void dispose() {
    //  listener.cancel();
    super.dispose();
  }

  Future<void> google() async {
    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
    provider.login();
  }

  @override
  Widget build(BuildContext context) => Container(
        // width: 230,
        padding: EdgeInsets.all(4),
        child: Center(
          child: ElevatedButton(
            child: Text('Google SignIn'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            onPressed: () {
              google();
              // final provider =
              // Provider.of<GoogleSignInProvider>(context, listen: false);
              // provider.login();
            },
            // icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
          ),
        ),
      );
}
