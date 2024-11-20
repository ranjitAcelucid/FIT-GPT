// Function to get dynamic font size based on screen width
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sales/utils/constants/colors.dart';
import 'package:sales/utils/constants/responsive.dart';

double getDynamicFontSize(BuildContext context, double baseFontSize) {
  final double screenWidth = MediaQuery.of(context).size.width;
  // Assuming 375 as the base width for reference
  return baseFontSize * (screenWidth / 375);
}

// Function to get dynamic text style
TextStyle getDynamicTextStyle(BuildContext context, TextStyle baseStyle) {
  return baseStyle.copyWith(
    fontSize: getDynamicFontSize(context, baseStyle.fontSize ?? 14.0),
  );
}

// screen height
double screenHeight(context, double factor) {
  return MediaQuery.of(context).size.height * factor;
}

// screen width
double screenWidth(context, double factor) {
  return MediaQuery.of(context).size.width * factor;
}

final headLineFontWeight500 = GoogleFonts.poppins(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: AppColors.black,
  letterSpacing: 0.4,
);

final headLineOpenSansFontWeight500 = GoogleFonts.openSans(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: AppColors.black,
  letterSpacing: 0.4,
);

final headLineFontWeight400 = GoogleFonts.poppins(
  fontSize: 16,
  fontWeight: FontWeight.w400,
  color: AppColors.black,
  letterSpacing: 0.4,
);

final headLineFontWeight600 = GoogleFonts.poppins(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: AppColors.black,
  letterSpacing: 0.4,
);

final headLineFontWeight300 = GoogleFonts.poppins(
  fontSize: 14,
  fontWeight: FontWeight.w300,
  color: AppColors.black,
  letterSpacing: 0.4,
);

final headLineFontWeight200 = GoogleFonts.poppins(
  fontSize: 14,
  fontWeight: FontWeight.w200,
  color: AppColors.black,
  letterSpacing: 0.4,
);

final headLineFontWeight700 = GoogleFonts.poppins(
  fontSize: 14,
  fontWeight: FontWeight.w700,
  color: AppColors.black,
  letterSpacing: 0.4,
);

final headLineFontWeight800 = GoogleFonts.poppins(
  fontSize: 14,
  fontWeight: FontWeight.w800,
  color: AppColors.black,
  letterSpacing: 0.4,
);

final headLineFontWeight900 = GoogleFonts.poppins(
  fontSize: 14,
  fontWeight: FontWeight.w900,
  color: AppColors.black,
  letterSpacing: 0.4,
);

final headLineFontWeightBold = GoogleFonts.poppins(
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: AppColors.black,
  letterSpacing: 0.4,
);

// dynamic hint style
TextStyle dynamicHintStyle(BuildContext context) {
  return getDynamicTextStyle(
      context,
      headLineFontWeight400.copyWith(
          fontSize: Responsive.isMobile(context) ? 14 : 12,
          letterSpacing: 0.4,
          color: AppColors.dark6));
}
