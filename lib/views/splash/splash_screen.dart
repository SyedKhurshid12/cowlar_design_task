import 'dart:async';

import 'package:cowlar_design_task/views/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: _buildBody(),
    );
  }

  // Method to navigate to the next screen after a delay
  void _navigateToNextScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const BottomNavBar()),
      );
    });
  }

  // Widget to build the body of the splash screen
  Widget _buildBody() {
    return Center(
      child: Image.asset(
        "assets/popcorn 1.png",
        height: 200,
        width: 200,
      ),
    );
  }
}
