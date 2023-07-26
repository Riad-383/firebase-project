import 'dart:async';

import 'package:firebase_project/Ui/uth/login_screen.dart';
import 'package:flutter/material.dart';

class SplashServices {
  void islogin(BuildContext context) {
    Timer(
        const Duration(seconds: 3),
        () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            )));
  }
}
