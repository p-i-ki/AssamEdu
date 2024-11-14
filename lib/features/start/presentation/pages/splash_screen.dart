import 'dart:async';
import 'package:assam_edu/core/routes/names.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      //check if the user has loggedin.. if yes then show him the home page..this is done in the generateRoute()
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.GET_STARTED, (route) => false);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(253, 247, 239, 1.0),
      body: Center(
        child: Image.asset('assets/images/logo.png'),
      ),
    );
  }
}
