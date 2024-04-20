import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:s_group/LoginPage.dart';
import 'package:s_group/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Screen',
      theme: ThemeData(
        primaryColor: Color(0xFF274060), // Set primary color to brand color
        scaffoldBackgroundColor: Color(0xFFFFFFFF), // Set accent color to white
        // hintColor: Color(0xFFFFFFFF), // Set accent color to white

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
      // home: GenerateBill(),
    );
  }
}
