import 'package:asala_saudi/feature/presentation/auth/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helpers/colors/colors.dart';
import '../../../core/helpers/extentions/extentions.dart';
import '../../../core/networking/web_services.dart';
import '../../../core/routing/routing.dart';
import '../../model/user/user.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController specializationController =
  TextEditingController();
  final formKey = GlobalKey<FormState>();
  final WebServices webServices = WebServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(25.w),
            child: Form(
              key: formKey,
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //  verticalSpace(5),
                  Container(
                      width: 150.w,
                      margin: EdgeInsets.all(10.w),
                      child: Image.asset("assets/images/asala-white.png")),
                  Text(
                    'ASALA SAUDI',
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Welcome to the innovators of the future',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 25.h),
                  AppTextFormField(
                    textFormController: fullNameController,
                    hintText: 'Enter your full name',
                    validator: (String) => genericValidator(String),
                  ),
                  const SizedBox(height: 10),
                  AppTextFormField(
                    textFormController: userNameController,
                    hintText: 'Enter your user name',
                    validator: (String) => genericValidator(String),
                  ),
                  const SizedBox(height: 10),
                  AppTextFormField(
                    textFormController: emailController,
                    hintText: 'Enter your email',
                    validator: (String) => emailValidator(String),
                  ),
                  const SizedBox(height: 10),
                  AppTextFormField(
                    textFormController: passwordController,
                    hintText: 'Enter your password',
                    validator: (String) => paswwordValidator(String),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          context.pushReplacementNamed(Routes.loginScreen);
                        },
                        child: const Text(
                          'I already have an account',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  ElevatedButton(
                    onPressed: () async {
                      HapticFeedback.lightImpact();
                      if (formKey.currentState!.validate()) {
                        String msg = await webServices.register(
                            User(
                              0,
                              userNameController.text.trim(),
                              emailController.text.trim(),
                              fullNameController.text.trim(),
                              "",[],[],[]
                            ),
                            passwordController.text.trim());
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(msg)),);
                        context.pushReplacementNamed(Routes.loginScreen);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryColor,
                      padding: EdgeInsets.symmetric(
                          vertical: 15.h, horizontal: 55.w),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Create account',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  genericValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "this field is required";
    }
    if (value.length < 4) {
      return "it must be at least 4 characters";
    }
  }
  paswwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "this field is required";
    }
    if (value.length < 8) {
      return "it must be at least 8 characters";
    }
  }
  emailValidator(value) {
    if (value == null || value.isEmpty) {
      return "Email is required"; // ✅ Empty email validation
    }
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return "Enter a valid email"; // ✅ Invalid email format validation
    }
    return null; // ✅ Email is valid

  }
}