import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../core/consts.dart';
import 'sign_up_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.all(BODY_PADDING),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: height(context) * 0.08),
                  Text('Test App',
                      style: TextStyle(
                          color: AppColors.TEXTCOLOR,
                          fontWeight: FontWeight.w700,
                          fontSize: 30)),
                  SizedBox(height: height(context) * 0.08),
                  Card(
                    child: const Padding(
                        padding: EdgeInsets.all(BODY_PADDING),
                        child: SignUpForm()),
                    shadowColor: AppColors.SHADOWCOLOR,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  SizedBox(height: height(context) * 0.08),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
