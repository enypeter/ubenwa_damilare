import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../../controllers/user_controller.dart';
import '../../../core/app_colors.dart';
import '../../../core/consts.dart';
import '../../../core/validator.dart';
import '../../../services/auth_services.dart';
import '../../widgets/bottons.dart';
import '../../widgets/loader.dart';
import '../../widgets/snackbar.dart';
import '../../widgets/text_field.dart';
import '../home/home_screen.dart';
import '../sign_up/sign_up_screen.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _storage = const FlutterSecureStorage();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isObscure = true;

  @override
  initState(){
    getUserEmail();
    super.initState();
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

  getUserEmail() async {
    var email = await _storage.read(key: "email");
    if (email != null) {
      emailController.text = email;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Login',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.TEXTCOLOR,
                  fontWeight: FontWeight.w700,
                  fontSize: 22)),
          SizedBox(height: height(context) * 0.03),
          textBoxTitle('Email'),
          InputFormField(
            hint: 'example@gmail.com',
            controller: emailController,
            validator: (value) => EmailValidator.validate(value),
          ),
          tinyVerticalSpace(),
          textBoxTitle('Password'),
          InputFormField(
            hint: '•••••••',
            obscure: isObscure,
            controller: passwordController,
            suffixIcon: _passwordVisibility(),
            validator: (value) => PasswordValidator.validate(value),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text('Forgot Password?',
                  style: TextStyle(
                      fontSize: 11,
                      color: AppColors.PRIMARY,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w500)),
            ),
          ),
          SizedBox(height: height(context) * 0.03),
          Button(
              text: 'Login',
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  signIn();
                }
              }),
          SizedBox(height: height(context) * 0.08),
          GestureDetector(
            onTap: () => Get.to(() => const SignUpScreen()),
            child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: TextStyle(
                        fontSize: 11,
                        color: AppColors.GREY,
                        fontWeight: FontWeight.w500),
                    children: [
                      const TextSpan(text: 'Don\'t have an account? '),
                      TextSpan(
                          text: 'Sign up',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: AppColors.PRIMARY,
                              fontWeight: FontWeight.w600)),
                    ])),
          ),
        ],
      ),
    );
  }

  Future signIn() async {
    showLoading(context);
    var response = await AuthenticationServices.login(
        emailController.text, passwordController.text);

    Get.back();
    if (response is String) {
      SnackBars.showErrorSnackBar('Oops!', response);
    } else {
      await _storage.write(key: "email", value: emailController.text);
      UserController userController =
          Get.put(UserController(), permanent: true);
      await userController.setUserDetails(response['user_info']);
      await userController.setToken(response['token']);
      Get.offAll(() =>  HomeScreen());
      SnackBars.showSuccessSnackBar('Successful!', 'Welcome Chief');
    }
  }
}
