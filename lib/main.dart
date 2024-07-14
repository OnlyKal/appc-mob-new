import 'package:appc/func/export.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ProvincesList(),
  ));
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
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
                    color: Colors.amber,
                  ),
                  child: Image.asset(
                    "assets/test.gif",
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
                  style: TextStyle(color: Colors.grey),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
