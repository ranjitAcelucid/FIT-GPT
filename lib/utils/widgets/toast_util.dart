import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:sales/utils/constants/colors.dart';

class ToastUtil {
  /// Displays a toast message with customizable options
  static void showToast({
    required String message,
    Color backgroundColor = AppColors.dark4,
    Color textColor = AppColors.white,
    ToastGravity gravity = ToastGravity.BOTTOM,
    int duration = 3,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: duration == 1 ? Toast.LENGTH_SHORT : Toast.LENGTH_LONG,
      gravity: gravity,
      timeInSecForIosWeb: duration,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 16.0,
    );
  }
}
