import 'package:flutter/material.dart';
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
import 'sign_up_success.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  bool isObscure = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
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
            validator: (value) => FieldValidator.validate(value),
          ),
          tinyVerticalSpace(),
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
            controller: passwordController,
            obscure: isObscure,
            suffixIcon: _passwordVisibility(),
            validator: (value) => PasswordValidator.validate(value),
          ),          tinyVerticalSpace(),

          RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  style: TextStyle(
                      fontSize: 10,
                      color: AppColors.GREY,
                      fontWeight: FontWeight.w500),
                  children: [
                    const TextSpan(
                        text:
                        'By entering your details, your are agreeing to our '),
                    TextSpan(
                        text: 'Terms of Service',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: AppColors.PRIMARY,
                            fontWeight: FontWeight.w600)),
                    const TextSpan(
                        text: ' and '),
                    TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: AppColors.PRIMARY,
                            fontWeight: FontWeight.w600)),
                    const TextSpan(
                        text: ' Thanks'),
                  ])),

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
            onTap: () => Get.back(),
            child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: TextStyle(
                        fontSize: 11,
                        color: AppColors.GREY,
                        fontWeight: FontWeight.w500),
                    children: [
                      const TextSpan(
                          text: 'Already have an account? '),
                      TextSpan(
                          text: 'Login',
                          style: TextStyle(
                              decoration:
                              TextDecoration.underline,
                              color: AppColors.PRIMARY,
                              fontWeight: FontWeight.w600)),
                    ])),
          ),

        ],
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
    Get.back();
    if (response is String) {
      SnackBars.showErrorSnackBar('Oops!', response);
    } else {
      UserController userController =
          Get.put(UserController(), permanent: true);
      await userController.setUserDetails(response['user_info']);
      await userController.setToken(response['token']);
      Get.offAll(() => const SuccessScreen());
    }
  }
}
