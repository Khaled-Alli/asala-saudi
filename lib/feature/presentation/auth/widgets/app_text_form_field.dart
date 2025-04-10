import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/colors/colors.dart';

class AppTextFormField extends StatelessWidget {
  AppTextFormField({
    super.key,
    required this.textFormController,
    required this.hintText,
    required this.validator,
  });

  TextEditingController textFormController;
  String hintText;
  Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      child: TextFormField(
        controller: textFormController,
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
          hintText: hintText,
          errorStyle: const TextStyle(color: Colors.red),
        ),
        keyboardType: TextInputType.text,
        //  textDirection:TextDirection.rtl,
        validator: (value) {
          return validator(value);
        },
      ),
    );
  }
}
