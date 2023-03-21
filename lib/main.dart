import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_demo/Home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'authgate.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Firebase Demo",
      debugShowCheckedModeBanner: false,
      //home: AuthGate(),
      home: Home(),
    );
  }
}

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  void initState() {
    super.initState();
    validateAuth();
  }

  validateAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("userUID");
    if (id != null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: ((context) => const Home())),
          (route) => false);
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: ((context) => const AuthGate())),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
