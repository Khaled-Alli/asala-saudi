import 'package:asala_saudi/core/helpers/colors/colors.dart';
import 'package:asala_saudi/core/helpers/extentions/extentions.dart';
import 'package:asala_saudi/core/networking/web_services.dart';
import 'package:asala_saudi/feature/presentation/auth/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/routing/routing.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberMe = true;
  final formKey = GlobalKey<FormState>();
  final WebServices webServices=WebServices();
  @override
  void initState() {
    super.initState();
    // _loadSavedCredentials();
  }

  // Future<void> _loadSavedCredentials() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String? savedName = prefs.getString('username');
  //   String? savedPassword = prefs.getString('password');
  //   bool? savedRememberMe = prefs.getBool('rememberMe');
  //
  //   setState(() {
  //     rememberMe = savedRememberMe;
  //   });
  //
  //   if (savedPassword != null && rememberMe) {
  //     nameController.text = savedName;
  //     passwordController.text = savedPassword;
  //     _login();
  //   }
  // }

  // Future<void> _login() async {
  // final prefs = await SharedPreferences.getInstance();
  // String? savedName = prefs.getString('username');
  // String? savedPassword = prefs.getString('password');

  //   if (savedName == nameController.text && savedPassword == passwordController.text) {
  //     showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         title: const Text('Success'),
  //         content: const Text('Login successful!'),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               // Navigator.pop(context);
  //               // Navigator.pushReplacement(
  //               //   context,
  //               //   MaterialPageRoute(builder: (context) => const MainScreen()),
  //               // );
  //             },
  //             child: const Text('OK'),
  //           ),
  //         ],
  //       ),
  //     );
  //     if (rememberMe) {
  //       await prefs.setString('username', nameController.text);
  //       await prefs.setString('password', passwordController.text);
  //       await prefs.setBool('rememberMe', rememberMe);
  //     }
  //   } else {
  //     showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         title: const Text('Error'),
  //         content: const Text('Invalid username or password!'),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.pop(context),
  //             child: const Text('OK'),
  //           ),
  //         ],
  //       ),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(25.w),
            child: Form(
              key:formKey ,
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  verticalSpace(45),
                  Container(
                      width: 150.w,
                      margin: EdgeInsets.all(15.w),
                      child: Image.asset("assets/images/asala-white.png")),
                  Text(
                    'ASALA SAUDI',
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 50.h),
                  AppTextFormField(
                    textFormController: nameController,
                    hintText: 'Enter your name',
                    validator: (String)=>genericValidator(String),
                  ),
                  const SizedBox(height: 20),
                  AppTextFormField(
                    textFormController: passwordController,
                    hintText: 'Enter your password',
                    validator: (String)=>genericValidator(String),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Transform.scale(
                        scale: 1.2, // Adjust the scale as needed
                        child: Checkbox(
                          value: rememberMe,
                          onChanged: (value) {
                            setState(() {
                              HapticFeedback.lightImpact();
                              rememberMe = value!;
                            });
                          },
                          activeColor: AppColors.secondaryColor, // Replace with your AppColors.secondaryColor
                          shape: CircleBorder(side: BorderSide(color: Colors.white),),
                          autofocus: true,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // Remove extra padding
                        ),
                      ),
                      const Text(
                        'Remember me',
                        style: TextStyle(color: Colors.white),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.lightImpact();
                        context.pushReplacementNamed(Routes.registerScreen);
                          },
                        child: const Text(
                          'Create an account',
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
                    onPressed: () async{
                      HapticFeedback.lightImpact();
                     if (formKey.currentState!.validate()){
                    final bool isLogedIn = await webServices.login(nameController.text.trim(), passwordController.text.trim());
                       isLogedIn  ?
                     context.pushReplacementNamed(Routes.layoutScreen) :
                     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('login failed')),);
                     }

                    }, //_login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryColor,
                      padding:
                          EdgeInsets.symmetric(vertical: 15.h, horizontal: 70.w),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Login',
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
  genericValidator(value) {
    if (value == null || value.isEmpty ) {
      return "this field is required";
    }
  }
}
