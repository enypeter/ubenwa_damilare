import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubenwa_damilare/core/app_colors.dart';
import 'package:ubenwa_damilare/views/screens/home/home_screen.dart';
import '../../../core/app_assets.dart';
import '../../../core/consts.dart';

class SuccessScreen extends StatelessWidget {
   const SuccessScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Column(
          children: [
            SizedBox(height: height(context) * 0.15),
            Image.asset(GIF_IMAGE),
          ],
        ),
        Column(
          children: [
            SizedBox(height: height(context) * 0.2),
            Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.PRIMARY.withOpacity(0.2)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                      child:
                          Icon(Icons.check, color: AppColors.PRIMARY, size: 100)),
                )),
            const SizedBox(height: 25),
            Center(
              child: Text(
                'Congratulation',
                style: TextStyle(
                    color: AppColors.PRIMARY,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: height(context) * 0.1),
            Text(
              'Kindly Check your email for verification\nWelcome to an amazing experience with Ubenwa',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.TEXTCOLOR,
                  fontSize: 16),
            ),
            SizedBox(height: height(context) * 0.2),
            GestureDetector(
              onTap: () => Get.offAll(() =>  HomeScreen()),
              child: Column(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.PRIMARY,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                            child: Icon(Icons.arrow_forward,
                                color: AppColors.WHITE, size: 30)),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Let\'s go',
                      style: TextStyle(
                          color: AppColors.TEXTCOLOR,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
