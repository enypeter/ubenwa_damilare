 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubenwa_damilare/core/app_colors.dart';

class SnackBars{

  static showErrorSnackBar(String title, String message) {
  Get.snackbar(title, message,
      icon: Icon(Icons.error_outlined, color: AppColors.WHITE),
      backgroundColor:AppColors.RED,
      borderRadius: 5,
      colorText:AppColors. WHITE,
      duration: const Duration(seconds: 2));
}

static showSuccessSnackBar(String title, String message) {
  Get.snackbar(title, message,
      icon: Icon(Icons.check_circle, color: AppColors.WHITE),
      borderRadius: 5,
      backgroundColor: AppColors.GREEN,
      colorText: AppColors.WHITE);
}

 static showNoticeSnackBar(String title, String message) {
  Get.snackbar(
    'Hi Chief!',
    message,
    borderRadius: 5,
    duration: const Duration(seconds: 4),
    backgroundColor: AppColors.TEXTCOLOR,
    colorText: AppColors.WHITE,
  );
}}