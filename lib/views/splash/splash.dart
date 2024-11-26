import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sales/utils/constants/app_style.dart';
import 'package:sales/utils/constants/colors.dart';
import 'package:sales/utils/constants/images.dart';
import 'package:sales/views/auth/login.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool checkRememberMe = false;
  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: false, max: 1);
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastOutSlowIn,
    );
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        isUserLoggedIn();
      }
    });

    _animationController.forward();

    super.initState();
  }

// check user is logged in or not
  isUserLoggedIn() async {
    // final userAuthCubit = context.read<UserLocalStorageCubit>();
    // final isUserAuthenticated = await userAuthCubit.isAuthenticatedUser();
    Navigator.pushAndRemoveUntil<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => const Login(),
      ),
      (route) => false,
    );
    // if (isUserAuthenticated) {
    //   Navigator.of(context).push(MaterialPageRoute(
    //     builder: (context) => const Login(),
    //   ));
    // } else {
    //   Navigator.pushAndRemoveUntil<dynamic>(
    //     context,
    //     MaterialPageRoute<dynamic>(
    //       builder: (BuildContext context) => const Login(),
    //     ),
    //     (route) => false,
    //   );
    // }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Image background
          SizedBox.expand(
            child: Image.asset(
              Images.splashBg,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'FIT GPT',
                  style: GoogleFonts.bungeeShade(
                      fontSize: getDynamicFontSize(context, 50),
                      color: AppColors.primary),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Fuel Your Goals, One Meal at a Time.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.bungeeInline(
                        fontSize: getDynamicFontSize(context, 20),
                        color: AppColors.primary),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
