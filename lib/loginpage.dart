import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:google_fonts/google_fonts.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:news_app/first_page.dart';
import 'package:news_app/google.dart';
import 'package:news_app/home.dart';
import 'package:news_app/secondpage.dart';

import 'package:provider/provider.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  bool devicecheck = false;
  @override
  Widget build(BuildContext context) => Scaffold(
        body: ChangeNotifierProvider(
          create: (context) => GoogleSignInProvider(),
          child: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              final provider = Provider.of<GoogleSignInProvider>(context);
              if (provider.isSigningIn) {
                return buildLoading();
              } else if (snapshot.hasData) {
                // UserHelper.saveUser(snapshot.data);
                // userData.saveuserdata(snapshot.data);
                // UserDevice.saveuserdevice(snapshot.data);
                Future.delayed(Duration(seconds: 2));
                return const Secondpage();
              } else {
                return GoogleSignupButtonWidget();
              }
            },
          ),
        ),
      );

  Widget buildLoading() => Container(child: Text('Copyrights'));
}
