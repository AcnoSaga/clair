import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:hackcom_2021/services/authentication_service.dart';
import 'package:hackcom_2021/theme/size_config.dart';

import '../../gap.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0E0E0E),
      body: SafeArea(
        child: Column(
          children: [
            Gap(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Spacer(flex: 4),
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
                  flex: 2,
                  child: Hero(
                    tag: 'logo_name',
                    child: Container(
                      child: Image.asset('assets/images/clairtext.png'),
                    ),
                  ),
                ),
                Spacer(flex: 4),
              ],
            ),
            Gap(height: 8),
            Text(
              'clair it out',
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: sText * 10,
                fontWeight: FontWeight.w500,
              ),
            ),
            Gap(height: 20),
            SignInButton(
              Buttons.Google,
              text: "Sign up with Google",
              onPressed: () => authenticationService.signInWithGoogle(),
            )
          ],
        ),
      ),
    );
  }
}
