import 'package:flutter/material.dart';

import '../../core/app_colors.dart';

class Button extends StatelessWidget {
  const Button({Key? key,this.onTap, required this.text}) : super(key: key);
  final onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
          child: InkWell(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.PRIMARY,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 50,
              width: 110,
              child: Center(
                  child: Text(
                    text,
                    style: TextStyle(
                        color: AppColors.WHITE,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.2,
                        fontSize: 16),
                  )),
            ),
          ),
        ),
      ],
    );
  }
}

