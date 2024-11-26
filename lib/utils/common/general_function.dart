import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sales/utils/constants/app_style.dart';
import 'package:sales/utils/constants/colors.dart';
import 'package:sales/utils/constants/responsive.dart';

class GeneralFunction {
  // common svg icon
  SvgPicture commonSvgIcon(
      String iconName, BuildContext context, bool toggleColor) {
    return SvgPicture.asset(
      iconName,
      width:
          screenHeight(context, Responsive.isMobile(context) ? 0.016 : 0.028),
      height:
          screenHeight(context, Responsive.isMobile(context) ? 0.016 : 0.028),
      colorFilter: ColorFilter.mode(
          toggleColor ? AppColors.dark9 : AppColors.primary, BlendMode.srcIn),
    );
  }
}
