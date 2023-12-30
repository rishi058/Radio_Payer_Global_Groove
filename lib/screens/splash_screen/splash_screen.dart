import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:global_groove/controller/audio_controller/audio_controllers.dart';
import 'package:global_groove/sizer/sizer.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;

  @override
  void initState() {
    Get.put(RadioIdController());
    startTimer(context);
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  startTimer(BuildContext ctx) {
    _timer = Timer(const Duration(seconds: 2), () {
      Navigator.popAndPushNamed(ctx, 'home-screen');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Global Groove',
                style: TextStyle(
                  fontSize: 12.sp,
                  letterSpacing: 4,
                  fontWeight: FontWeight.w800,
                  color: const Color.fromRGBO(134, 132, 209, 1),
                ),
              ),
              SizedBox(
                  width: 50.w,
                  child: Lottie.asset('assets/loading.json')),
            ],
          ),
        ),
      ),
    );
  }
}
