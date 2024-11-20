import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sales/utils/constants/app_style.dart';
import 'package:sales/utils/constants/colors.dart';
import 'package:sales/utils/constants/responsive.dart';

class CommonButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final Color buttonColor;
  final Color buttonTextColor;
  final double? height;
  final double? width;
  final double? fontSize;
  final bool isLoading;
  const CommonButton(
      {super.key,
      required this.onPressed,
      required this.buttonText,
      required this.buttonColor,
      required this.buttonTextColor,
      this.height,
      this.width,
      this.fontSize,
      required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
            backgroundColor: WidgetStateProperty.all<Color>(buttonColor),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(Responsive.isMobile(context) ? 8 : 10),
            ))),
        onPressed: isLoading ? () {} : onPressed,
        child: isLoading
            ? const SpinKitThreeBounce(
                color: AppColors.white,
                size: 30,
              )
            : Text(
                buttonText,
                style: getDynamicTextStyle(
                    context,
                    headLineFontWeight500.copyWith(
                        color: buttonTextColor,
                        fontSize: fontSize,
                        letterSpacing: 0.6)),
              ),
      ),
    );
  }
}
