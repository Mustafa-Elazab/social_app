import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:social_app/layout/home_layout.dart';
import 'package:social_app/modeuls/user/login_screen/login_screen.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Timer(
        Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context,
            PageTransition(
                child: FirebaseAuth.instance.currentUser != null
                    ? HomeLayout()
                    : LoginScreen(),
                type: PageTransitionType.leftToRightWithFade)));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 400,
              height: 200,
              child: Lottie.asset('assets/images/social.json'),
            ),
            RichText(
                text: TextSpan(
                    text: 'Ma',
                    style: TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                  TextSpan(
                    text: 'Tea',
                    style: TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ]))
          ],
        ),
      ),
    );
  }
}
