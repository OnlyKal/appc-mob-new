import 'dart:async';

import 'package:appc/func/export.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PopScope(canPop: false, child: SplashScreen()),
  ));
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  checkSession() async {
    hideKeyboard();
    Timer(const Duration(seconds: 3), () async {
      SharedPreferences auth = await SharedPreferences.getInstance();
      var matricule = auth.getString("matricule");
      if (matricule == null || matricule == "") {
        goTo(context, const SignIn());
      } else {
        goTo(context, const HomePage());
      }
    });
  }

  @override
  void initState() {
    checkSession();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/bgsplash2.png"), fit: BoxFit.cover),
            ),
            height: fullHeight(context),
            width: fullWidth(context),
            child: Column(
              children: [
                Container(
                  height: fullHeight(context) * 0.62,
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 220,
                    width: 220,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(110),
                      color: Colors.transparent,
                    ),
                    child: Image.asset(
                      "assets/giflogo.gif",
                      // height: 200,
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.all(20),
                  child: const Text(
                    "APPC SERVICES © 2024",
                    style: TextStyle(color: Color.fromARGB(255, 112, 111, 111)),
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
