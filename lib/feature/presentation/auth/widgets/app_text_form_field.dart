import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/colors/colors.dart';

class AppTextFormField extends StatefulWidget {
  AppTextFormField({
    super.key,
    required this.textFormController,
    required this.hintText,
    required this.validator,
    this.isPassword = false ,
  });

  TextEditingController textFormController;
  String hintText;
  Function(String?) validator;
  bool isPassword;

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      child: TextFormField(
        controller: widget.textFormController,
        decoration:  InputDecoration(
            constraints: BoxConstraints(maxHeight: 100.h, minHeight: 100.h),
           // labelText: "Your Label",
          contentPadding:  EdgeInsets.symmetric(vertical: 20.h,horizontal: 10.w),
        // decoration: InputDecoration(
         fillColor:AppColors.appWhiteColor ,
         filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: AppColors.mainColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide:  BorderSide(
              color: AppColors.mainColor,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide:  BorderSide(
              color: Colors.red,
            ),
          ),
          focusedErrorBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: AppColors.mainColor,
            ),
          ),
          //prefixIcon: prefixIcon,
          hintText: widget.hintText,
          suffixIcon:
          widget.isPassword?
          IconButton(
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
            icon: Icon(
              !obscureText ? Icons.visibility : Icons.visibility_off,
              color: AppColors.mainColor,
            ),
          ):SizedBox(),
          errorStyle: const TextStyle(color: Colors.red),
        ),
        obscureText: obscureText,
        keyboardType: TextInputType.text,
        //  textDirection:TextDirection.rtl,
        validator: (value) {
          return widget.validator(value);
        },
      ),
    );
  }
}
