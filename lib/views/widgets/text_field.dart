
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';

class InputFormField extends StatelessWidget {
  const InputFormField({
    this.suffixIcon,
    this.validator,
    this.obscure = false,
    this.onChanged,
    this.enabled = true,
    this.controller,
    this.hint,
    this.textCapitalization = TextCapitalization.none,
    this.keyboardType,
    Key?key
  }): super(key: key);

  final suffixIcon;
  final onChanged;
  final validator;
  final enabled;
  final controller;
  final obscure;
  final hint;
  final textCapitalization;
  final  keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 7, 0, 7),
      child: TextFormField(
        enabled: enabled,
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(fontSize: 14, color: AppColors.GREY),
        textCapitalization: textCapitalization,
        validator: validator,
        onChanged: onChanged,
        obscureText: obscure,
        obscuringCharacter: '•',
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.FILLGREY.withOpacity(0.6),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.FILLGREY, width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(10.0))),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.FILLGREY.withOpacity(0.7), width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(10.0))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.FILLGREY.withOpacity(0.7), width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(10.0))),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.redAccent),
          ),
          focusedErrorBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          suffixIcon: suffixIcon,
          hintText: hint,
          hintStyle: TextStyle(fontSize: 14, color: AppColors.DISABLEDCOLOR),
          contentPadding:
          const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
        ),
      ),
    );
  }
}

Text textBoxTitle(text) => Text(' $text',
    style: TextStyle(
        fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.TEXTCOLOR));
