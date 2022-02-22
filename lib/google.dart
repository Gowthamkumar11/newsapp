import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

dynamic deviceId;

abstract class AuthBase {
  User get currentUser1;

  // Future<User> signInWithEmail(String _email, String _password);
  //Future<User> createEmailWithPassword(String _email, String _password);

  Future<void> logout();
}

class GoogleSignInProvider extends ChangeNotifier implements AuthBase {
  final googleSignIn = GoogleSignIn();
  late bool _isSigningIn;

  GoogleSignInProvider() {
    _isSigningIn = false;
  }

  bool get isSigningIn => _isSigningIn;

  set isSigningIn(bool isSigningIn) {
    _isSigningIn = isSigningIn;
    notifyListeners();
  }

  Future login() async {
    isSigningIn = true;

    final user = await googleSignIn.signIn();
    if (user == null) {
      isSigningIn = false;
      return;
    } else {
      final googleAuth = await user.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      isSigningIn = false;
    }
  }

  Future<void> logout() async {
    await googleSignIn.signOut();
    FirebaseAuth.instance.signOut();
  }

  @override
  // TODO: implement currentUser1
  User get currentUser1 => throw UnimplementedError();
}

class userData {
  static FirebaseFirestore _db1 = FirebaseFirestore.instance;
  static saveuserdata(User user) async {
    Map<String, dynamic> userInfo = {
      'name': user.displayName,
      'email': user.email,
    };
    final userRef1 = _db1.collection('UserDataForPromo').doc(user.uid);
    if ((await userRef1.get()).exists) {
      await null;
    } else {
      userRef1.set(userInfo);
    }
  }
}

class UserDevice {
  static FirebaseFirestore _db2 = FirebaseFirestore.instance;

  static saveuserdevice(User user) async {
    DeviceInfoPlugin deviceInfoPlugin1 = DeviceInfoPlugin();
    final deviceInfo = await deviceInfoPlugin1.androidInfo;
    deviceId = deviceInfo.androidId;
    Map<String, dynamic> userInfo1 = {
      'name': user.email,
      'deviceid': deviceId,
    };
    final userRef1 = _db2.collection('UserDeviceChecking').doc(user.uid);
    final nowMs = Timestamp.now();
    if ((await userRef1.get()).exists) {
      await userRef1.update({
        'update at': nowMs,
      });
    } else {
      userRef1.set(userInfo1);
    }
  }
}

class UserHelper {
  static FirebaseFirestore _db = FirebaseFirestore.instance;
  static saveUser(User user) async {
    //  PackageInfo packageInfo = await PackageInfo.fromPlatform();
    //int buildNumber = int.parse(packageInfo.buildNumber);
    Map<String, dynamic> userData = {
      'name': user.displayName,
      'image': user.photoURL,
      'email': user.email,
      'phoneNumber': user.phoneNumber,
      'address': null,
      'last login': user.metadata.lastSignInTime,
      'created at': Timestamp.now(),
      'profile update': '',
      'Banking Course': 'General',
      'UserChoosenCourse': 'Bank Exam',
      //  'build number': buildNumber,
      'loginCount': 1
    };

    final userRef = _db.collection('NewUsers').doc(user.uid);
    if ((await userRef.get()).exists) {
      await userRef.update({
        "last login": user.metadata.lastSignInTime,
        // "build number": buildNumber,
        'loginCount': 2
      });
    } else {
      await userRef.set(userData);
    }
    // await _saveDevice(user);
  }

  // static _saveDevice(User user) async {
  //   DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  //   String deviceId;
  //   Map<String, dynamic> deviceData;
  //   if (Platform.isAndroid) {
  //     final deviceInfo = await deviceInfoPlugin.androidInfo;
  //     deviceId = deviceInfo.androidId;
  //     deviceData = {
  //       'os version': deviceInfo.version.sdkInt.toString(),
  //       'platform': 'android',
  //       'model': deviceInfo.model,
  //       'device': deviceInfo.device
  //     };
  //   }
  //   if (Platform.isIOS) {
  //     final deviceInfo = await deviceInfoPlugin.iosInfo;
  //     deviceId = deviceInfo.identifierForVendor;
  //     deviceData = {
  //       'os version': deviceInfo.systemVersion,
  //       'platform': 'IOS',
  //       'model': deviceInfo.model,
  //       'device': deviceInfo.name
  //     };
  //   }
  //   final nowMs = Timestamp.now();

  //   final deviceRef = _db
  //       .collection('NewUsers')
  //       .doc(user.uid)
  //       .collection('device')
  //       .doc(deviceId);
  //   if ((await deviceRef.get()).exists) {
  //     await deviceRef.update({'update at': nowMs, 'uninstalled': false});
  //   } else {
  //     await deviceRef.set({
  //       'created at': nowMs,
  //       'updated at': nowMs,
  //       'uninstalled': false,
  //       'id': deviceId,
  //       'device info': deviceData,
  //     });
  // }
  // }
}
