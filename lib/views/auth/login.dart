import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales/cubit/auth/auth_cubit.dart';
import 'package:sales/cubit/auth/auth_state.dart';
import 'package:sales/utils/common/general_function.dart';
import 'package:sales/utils/constants/app_style.dart';
import 'package:sales/utils/constants/colors.dart';
import 'package:sales/utils/constants/images.dart';
import 'package:sales/utils/constants/regex.dart';
import 'package:sales/utils/constants/responsive.dart';
import 'package:sales/utils/constants/strings.dart';
import 'package:sales/utils/widgets/common_button.dart';
import 'package:sales/utils/widgets/common_input_box.dart';
import 'package:sales/utils/widgets/nutmeg_logo.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = true, rememberMe = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: AppColors.primary,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const NutmegLogo(),
          SizedBox(
            height: screenHeight(context, 0.015),
          ),
          Form(
            key: _formKey,
            child: Container(
              width: screenWidth(
                  context, Responsive.isTablet(context) ? 0.85 : 0.95),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.signIn,
                    style: getDynamicTextStyle(
                      context,
                      headLineFontWeight600.copyWith(
                          color: AppColors.dark1,
                          fontSize: Responsive.isMobile(context) ? 18 : 14),
                    ),
                  ),
                  SizedBox(height: screenHeight(context, 0.03)),
                  CommonInputBox(
                    controller: emailController,
                    hintStyle: dynamicHintStyle(context),
                    hintText: AppStrings.email,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    prefixIcon: GeneralFunction()
                        .commonSvgIcon(Images.email, context, true),
                    overrideValidator: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppStrings.plsEnterYourEmail;
                      } else if (!RegExp(AppRegex.email)
                          .hasMatch(emailController.text)) {
                        return AppStrings.plsEnterYourCorrectEmail;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight(context, 0.02)),
                  CommonInputBox(
                    controller: passwordController,
                    hintStyle: dynamicHintStyle(context),
                    hintText: AppStrings.password,
                    textInputAction: TextInputAction.done,
                    obscureText: _passwordVisible,
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: GeneralFunction()
                        .commonSvgIcon(Images.password, context, true),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                      child: GeneralFunction()
                          .commonSvgIcon(Images.eye, context, _passwordVisible),
                    ),
                    overrideValidator: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppStrings.plsEnterYourPassword;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight(context, 0.02)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Transform.scale(
                              scale: Responsive.isMobile(context) ? 1.2 : 1.8,
                              child: Checkbox(
                                value: rememberMe,
                                activeColor: AppColors.primary,
                                side: const BorderSide(
                                    width: 1.5, color: AppColors.secondary),
                                onChanged: (value) {
                                  setState(() {
                                    rememberMe = value!;
                                  });
                                },
                              )),
                          SizedBox(
                            width: Responsive.isMobile(context)
                                ? MediaQuery.of(context).size.width * 0.005
                                : MediaQuery.of(context).size.width * 0.02,
                          ),
                          Text(AppStrings.rememberMe,
                              style: getDynamicTextStyle(
                                  context,
                                  headLineFontWeight400.copyWith(
                                    color: AppColors.dark4,
                                    fontSize:
                                        Responsive.isMobile(context) ? 14 : 12,
                                  )))
                        ],
                      ),
                      InkWell(
                        onTap: () {},
                        child: Ink(
                          child: Text(
                            AppStrings.forgotPassword,
                            style: getDynamicTextStyle(
                                context,
                                headLineFontWeight500.copyWith(
                                    fontSize:
                                        Responsive.isMobile(context) ? 12 : 10,
                                    color: AppColors.secondary7,
                                    letterSpacing: 0.4,
                                    fontWeight: FontWeight.w500,
                                    // decoration: TextDecoration.underline,
                                    decorationColor: AppColors.primary)),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: screenHeight(context, 0.05)),
                  BlocListener<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthErrorState) {}
                    },
                    child: CommonButton(
                        width: screenWidth(context,
                            Responsive.isTablet(context) ? 0.85 : 0.95),
                        height: screenHeight(context, 0.06),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {}
                        },
                        buttonText: AppStrings.signIn,
                        buttonColor: AppColors.primary,
                        buttonTextColor: AppColors.white,
                        fontSize: Responsive.isMobile(context) ? 16 : 14,
                        isLoading: false),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
