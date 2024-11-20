import 'package:flutter/material.dart';
import 'package:sales/utils/constants/app_style.dart';
import 'package:sales/utils/constants/images.dart';

class NutmegLogo extends StatelessWidget {
  const NutmegLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        Images.nutmegLogo,
        fit: BoxFit.cover,
        height: screenHeight(context, 0.09),
      ),
    );
  }
}
