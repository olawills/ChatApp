import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sociallite/constants/Constantcolors.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sociallite/screens/landingPage/landing_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ConstantColors constantColors = ConstantColors();

  @override
  void initState() {
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
          context,
          PageTransition(
              child: LandingPage(),
              type: PageTransitionType.leftToRight)),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constantColors.darkColor,
      body: Center(
        child: RichText(
          text: TextSpan(
            text: 'the',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: constantColors.whiteColor,
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'Socialite',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: constantColors.blueColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 35.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
