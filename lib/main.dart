import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reel_feel/authentication/authentication_controller.dart';
import 'package:reel_feel/authentication/login_screen.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();

   await Firebase.initializeApp().then((value) {
     Get.put(AuthenticationController());
   });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reel App',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: LoginScreen(),
    );
  }
}


