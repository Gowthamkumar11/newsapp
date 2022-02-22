import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:news_app/loginpage.dart';
import 'package:news_app/splash.dart';

//import 'google_sign.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen());
  }
}

//   Future getCurrentUser() async {
//     dynamic _user = FirebaseAuth.instance.currentUser!;
//     print(_user ?? "none");

//     return _user;
//   }
// }
