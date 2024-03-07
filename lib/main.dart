// import 'dart:async';
//
// import 'package:animated_splash_screen/animated_splash_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:jasgo/screens/login_screen.dart';
// import 'package:jasgo/widget/navigation_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
//
// StreamController<int> streamController = StreamController<int>.broadcast();
//
//
// void main() async {
//   SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//     statusBarColor: Colors.transparent,
//   ));
//   runApp(
//     const MyApp(),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: '',
//       debugShowCheckedModeBanner: false,
//       home: SplashScreen(),
//     );
//   }
// }
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   String device = "Android";
//
//   @override
//   void initState() {
//     super.initState();
//     Timer(const Duration(milliseconds: 3000), () => LoginScreen(device: '',));
//   }
//
//   @override
//   build(BuildContext context) {
//     return AnimatedSplashScreen(
//       splash: Image.asset("assets/images/jasgo_logo.png"),
//       backgroundColor: Color(0XFF0a1172),
//       duration: 3000,
//       splashIconSize: 200,
//       splashTransition: SplashTransition.fadeTransition,
//       nextScreen: LoginScreen(device: '',),
//     );
//   }
// /* checkLogin() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     var userToken = preferences.getString("data");
//     if (userToken != null) {
//       if (mounted) {
//         Navigator.of(context).pushAndRemoveUntil(
//             MaterialPageRoute(
//                 builder: (context) => BottomNavBar(
//                   device: device,
//                 )),
//                 (route) => false);
//       }
//     } else {
//       if (mounted) {
//         Navigator.of(context).pushAndRemoveUntil(
//             MaterialPageRoute(
//                 builder: (context) => IntroSliderScreen(device: device)),
//                 (route) => false);
//       }
//     }
//   }*/
// }




import 'dart:async';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jasgo/screens/login_screen.dart';
import 'package:jasgo/screens/wrapper.dart';
import 'package:jasgo/widget/navigation_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var user_id = prefs.getString("user_id");
 //For Firebase connection
  FirebaseOptions firebaseOptions = FirebaseOptions(
   // apiKey: "yAIzaSyBEr-LyPjrlkGt_OiT-7QX8bq2tjRczNxM",
    apiKey: "AIzaSyBEr-LyPjrlkGt_OiT-7QX8bq2tjRczNxM",
    authDomain: "your_auth_domain",
    projectId: "jasgo-bf2bd",
    storageBucket: "your_storage_bucket",
    messagingSenderId: "296396238554",
    appId: "1:296396238554:android:6960ae0a5d2ded5e8affe3",
    measurementId: "your_measurement_id",
  );
 await Firebase.initializeApp(
options: firebaseOptions
  );
  WidgetsFlutterBinding.ensureInitialized();

//  runApp(MyApp());
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: user_id == null ? const SplashScreen() : NavigationScreen(device: ''),
    ),
  );
}


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 3000), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen(device: '')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image.asset("assets/images/jasgo_logo.png"),
      backgroundColor: Color(0XFF0a1172),
      duration: 3000,
      splashIconSize: 200,
      splashTransition: SplashTransition.fadeTransition,
      nextScreen: LoginScreen(device: ''),
    );
  }
}
