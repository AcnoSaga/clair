import 'package:flutter/material.dart';

class loading_page extends StatelessWidget {
  const loading_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Color(0xFF0E0E0E),
          body: Center(
            child: Container(
              child: Image.asset('assets/logo.png'),
            ),
          )),
    );
  }
}
