import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackcom_2021/screens/login_screen/login_screen.dart';

// ignore: camel_case_types
class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final Timer _timer = Timer(Duration(seconds: 2), () {
    Get.offAll(() => LoginScreen());
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.black),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(flex: 6),
              Expanded(
                flex: 2,
                child: Container(
                  child: Hero(
                    tag: 'logo',
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ),
              ),
              Spacer(flex: 1),
              Expanded(
                flex: 1,
                child: Container(
                  child: Hero(
                    tag: 'logo_name',
                    child: Image.asset('assets/images/clairtext.png'),
                  ),
                ),
              ),
              Spacer(flex: 6),
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
