import 'package:flutter/material.dart';
import 'package:newapp/Screen/addTransactionScreen.dart';
import 'package:newapp/Screen/homeScreen.dart';
import 'package:newapp/Screen/splashScreen.dart';
//import 'package:newapp/createAccount/sign_Up.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Đảm bảo Flutter đã khởi tạo
  await Firebase.initializeApp(); // Khởi tạo Firebase

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SplashScreen(),
    );
  }
}
