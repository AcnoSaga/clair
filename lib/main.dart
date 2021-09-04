import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hackcom_2021/screens/home/home_page.dart';
import 'package:hackcom_2021/screens/login_screen/login_screen.dart';
import 'package:hackcom_2021/theme/size_config.dart';
import 'screens/landing_page/landing_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Clair',
      home: LayoutBuilder(
        builder: (context, snapshot) {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
          ]);
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              statusBarColor: Color(0x0F1D1D1D),
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarColor: Colors.white,
              systemNavigationBarIconBrightness: Brightness.dark,
            ),
          );
          SizeConfig.init(snapshot, Orientation.portrait);
          FirebaseAuth.instance.authStateChanges().listen((user) {
            if (user == null) {
              Get.offAll(() => LoginScreen());
            } else {
              Get.offAll(() => HomePage());
            }
          });
          return FirebaseAuth.instance.currentUser == null
              ? LandingPage()
              : HomePage();
        },
      ),
    );
  }
}
