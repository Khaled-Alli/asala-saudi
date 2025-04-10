import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


extension Navigation on BuildContext {
  Future<dynamic> pushNamed(String routeName, {Object? arguments})
  {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments})
  {
    return Navigator.of(this)
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(String routeName,
      {Object? arguments})
  {
    return Navigator.of(this)
        .pushNamedAndRemoveUntil(routeName, (Route<dynamic> route) => false, arguments: arguments);
  }

  void pop() => Navigator.of(this).pop(true);
}

extension StringExtension on String? {
  bool isNullOrEmpty() => this == null || this == "";
}


SizedBox verticalSpace(double height) => SizedBox(
  height: height.h,
);

SizedBox horizontalSpace(double width) => SizedBox(
  width: width.w,
);

