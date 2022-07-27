import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubenwa_damilare/views/screens/home_screen.dart';
import 'package:ubenwa_damilare/views/widgets/bottons.dart';
import 'package:ubenwa_damilare/views/widgets/snackbar.dart';
import '../../controllers/user_controller.dart';
import '../../core/app_colors.dart';
import '../../core/consts.dart';
import '../../core/validator.dart';
import '../../services/auth_services.dart';
import '../widgets/loader.dart';
import '../widgets/text_field.dart';
import 'sign_up.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isObscure = true;

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
                            validator: (value) =>
                                EmailValidator.validate(value),
                          ),
                          tinyVerticalSpace(),
                          textBoxTitle('Password'),
                          InputFormField(
                            hint: '•••••••',
                            obscure: isObscure,
                            controller: passwordController,
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() => isObscure = !isObscure);
                                },
                                icon: Icon(
                                    isObscure
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: AppColors.DISABLEDCOLOR)),
                            validator: (value) =>
                                PasswordValidator.validate(value),
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
                                        color: AppColors.PRIMARY,
                                        fontWeight: FontWeight.w500),
                                    children: [
                                      TextSpan(
                                          text: 'Don\'t have an account? ',
                                          style:
                                              TextStyle(color: AppColors.GREY)),
                                      TextSpan(
                                          text: 'Sign up',
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              color: AppColors.PRIMARY,
                                              fontWeight: FontWeight.w600)),
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

  Future signIn() async {
    showLoading(context);
    var response = await AuthenticationServices.login(
        emailController.text, passwordController.text);
    Get.back();
    if (response is String) {
      SnackBars.showErrorSnackBar('Oops!', response);
    } else {
      UserController userController =
      Get.put(UserController(), permanent: true);
      await userController.setUserDetails(response['user_info']);
      await userController.setToken(response['token']);
      await userController.setUserId(response['user_id']);
      Get.offAll(() => const HomeScreen());
      SnackBars.showSuccessSnackBar('Successful!', 'Welcome Chief');

    }
  }
}
