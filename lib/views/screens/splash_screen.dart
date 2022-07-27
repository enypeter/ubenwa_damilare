
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/app_assets.dart';
import '../../core/app_colors.dart';
import 'sign_in.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
        const Duration(seconds: 3), () => Get.to(() => const SignInScreen()));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
            'Test App',
            style: TextStyle(
                color: AppColors.TEXTCOLOR,
                fontWeight: FontWeight.w700,
                fontSize: 30),
          ),
        ),
        decoration:  const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(BACKGROUND))),
      ),
    );
  }
}