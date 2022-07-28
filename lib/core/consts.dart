import 'package:flutter/material.dart';

const String emptyEmailField = 'Email field cannot be empty!';
const String emptyPasswordField = 'Password field cannot be empty';
const String emptyTextField = 'Field cannot be empty!';
const String invalidPassword = 'Password should contain dot (.) and comma (,)';
const String invalidEmailField =
    "Email provided isn\'t valid.Try another email address";
const String passwordLengthError = 'Password length must be greater than 6';
const String dotRegex = r'^(?=.*?[.]).{8,}$';
const String commaRegex = r'^(?=.*?[,]).{8,}$';
const String emailRegex = '[a-zA-Z0-9\+\.\_\%\-\+]{1,256}' +
    '\\@' +
    '[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}' +
    '(' +
    '\\.' +
    '[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}' +
    ')+';



//MediaQuery Width
double width(BuildContext context) => MediaQuery.of(context).size.width;

//MediaQuery Height
double height(BuildContext context) => MediaQuery.of(context).size.height;

const BODY_PADDING = 25.0;

tinyVerticalSpace() => const SizedBox(height: 5);

smallVerticalSpace() => const SizedBox(height: 15);