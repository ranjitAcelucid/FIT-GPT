import 'package:flutter/material.dart';
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
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        toolbarHeight: 0,
        leading: const SizedBox(),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: AppColors.primary,
        child: Center(
          child: SizeTransition(
            sizeFactor: _animation,
            axis: Axis.horizontal,
            axisAlignment: -1,
            child: Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.5 -
                      AppBar().preferredSize.height),
              child: Image.asset(
                Images.nutmegLogo,
                fit: BoxFit.cover,
                // width: MediaQuery.of(context).size.width * 0.6,
                height: screenHeight(context, 0.1),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
