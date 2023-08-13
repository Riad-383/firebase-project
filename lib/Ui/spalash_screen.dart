import 'dart:io';

import 'package:firebase_project/firebase_services/splash%20services.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashScreen = SplashServices();
  @override
  void initState() {
    super.initState();
    // TODO: implement initState

    splashScreen.islogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: 
    
    Center(
      child: Image(
        fit: BoxFit.fill,
        image: AssetImage('images/1.png')),
    ));
  }
}
