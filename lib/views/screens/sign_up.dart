import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubenwa_damilare/services/auth_services.dart';
import 'package:ubenwa_damilare/views/screens/sign_up_success.dart';

import '../../controllers/user_controller.dart';
import '../../core/app_colors.dart';
import '../../core/consts.dart';
import '../../core/validator.dart';
import '../widgets/bottons.dart';
import '../widgets/loader.dart';
import '../widgets/snackbar.dart';
import '../widgets/text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isObscure = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(BODY_PADDING),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: height(context) * 0.08),
                Text(
                  'Test App',
                  style: TextStyle(
                      color: AppColors.TEXTCOLOR,
                      fontWeight: FontWeight.w700,
                      fontSize: 30),
                ),
                SizedBox(height: height(context) * 0.08),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(BODY_PADDING),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text('SignUp',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: AppColors.TEXTCOLOR,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22)),
                          SizedBox(height: height(context) * 0.03),
                          textBoxTitle('Name'),
                          InputFormField(
                            hint: 'Jane Doe',
                            controller: nameController,
                            textCapitalization: TextCapitalization.words,
                            validator: (value) =>
                                FieldValidator.validate(value),
                          ),
                          tinyVerticalSpace(),
                          textBoxTitle('Email'),
                          InputFormField(
                            hint: 'example@gmail.com',
                            controller: emailController,
                            validator: (value) =>
                                EmailValidator.validate(value),
                          ),
                          tinyVerticalSpace(),
                          textBoxTitle('Password'),
                          InputFormField(
                            hint: '•••••••',
                            controller: passwordController,
                            obscure: true,
                            suffixIcon: _passwordVisibility(),
                            validator: (value) =>
                                PasswordValidator.validate(value),
                          ),
                          SizedBox(height: height(context) * 0.03),
                          Button(
                              text: 'Sign up',
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  signUp();
                                }
                              }),
                          SizedBox(height: height(context) * 0.08),
                          GestureDetector(
                            onTap: () {},
                            child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: AppColors.PRIMARY,
                                        fontWeight: FontWeight.w500),
                                    children: [
                                      TextSpan(
                                          text:
                                              'By entering your details, your are agreeing to our ',
                                          style:
                                              TextStyle(color: AppColors.GREY)),
                                      TextSpan(
                                          text: 'Terms of Service',
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              color: AppColors.PRIMARY,
                                              fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: ' and ',
                                          style:
                                              TextStyle(color: AppColors.GREY)),
                                      TextSpan(
                                          text: 'Privacy Policy',
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              color: AppColors.PRIMARY,
                                              fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: ' Thanks',
                                          style:
                                              TextStyle(color: AppColors.GREY)),
                                    ])),
                          ),
                        ],
                      ),
                    ),
                  ),
                  shadowColor: const Color(0xFFFBF5FF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                SizedBox(height: height(context) * 0.08),
              ],
            ),
          ),
        )),
      ),
    );
  }

  IconButton _passwordVisibility() {
    return IconButton(
        onPressed: () => setState(() => isObscure = !isObscure),
        icon: Icon(
            isObscure
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: AppColors.DISABLEDCOLOR));
  }

  Future signUp() async {
    showLoading(context);
    var response = await AuthenticationServices.register(
        firstName: nameController.text.split(' ').first,
        lastName: nameController.text.split(' ')[1],
        email: emailController.text,
        password: passwordController.text);
    print(response);
    Get.back();
    if (response is String) {
      SnackBars.showErrorSnackBar('Oops!', response);
    } else {
      UserController userController =
          Get.put(UserController(), permanent: true);
      var token = response['token'];
      await userController.setUserDetails(response);
      await userController.setToken(token);
      Get.offAll(() => const SuccessScreen());
    }
  }
}
