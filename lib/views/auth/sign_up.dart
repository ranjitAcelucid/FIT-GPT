import 'package:flutter/material.dart';
import 'package:sales/utils/constants/app_style.dart';
import 'package:sales/utils/constants/colors.dart';
import 'package:sales/utils/constants/images.dart';
import 'package:sales/utils/constants/responsive.dart';
import 'package:sales/utils/constants/strings.dart';
import 'package:sales/utils/widgets/common_button.dart';
import 'package:sales/utils/widgets/common_input_box.dart';
import 'package:sales/views/auth/basic_details.dart';

class SignUp extends StatefulWidget {
  final bool isUser;
  const SignUp({super.key, required this.isUser});

  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Image background
          SizedBox.expand(
            child: Image.asset(
              Images.signupBgImg,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: screenWidth(
                      context, Responsive.isTablet(context) ? 0.85 : 0.95),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                      color: Colors.transparent.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(16)),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          AppStrings.signUp,
                          style: getDynamicTextStyle(
                            context,
                            headLineFontWeight600.copyWith(
                                color: AppColors.white,
                                fontSize:
                                    Responsive.isMobile(context) ? 18 : 14),
                          ),
                        ),
                        SizedBox(height: screenHeight(context, 0.03)),
                        CommonInputBox(
                          controller: emailController,
                          hintStyle: dynamicHintStyle(context, true),
                          hintText: AppStrings.email,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your email";
                            } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(value)) {
                              return "Please enter a valid email";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        CommonInputBox(
                          controller: passwordController,
                          hintStyle: dynamicHintStyle(context, true),
                          hintText: "Password",
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.next,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your password";
                            } else if (value.length < 6) {
                              return "Password must be at least 6 characters long";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        CommonInputBox(
                          controller: confirmPasswordController,
                          hintStyle: dynamicHintStyle(context, true),
                          hintText: "Confirm Password",
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please confirm your password";
                            } else if (value != passwordController.text) {
                              return "Passwords do not match";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        CommonButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => BasicDetails(
                                    isUser: widget.isUser,
                                  ),
                                ));
                              }
                            },
                            buttonText: AppStrings.signUp,
                            buttonColor: AppColors.primary,
                            buttonTextColor: AppColors.white,
                            width: screenWidth(context,
                                Responsive.isTablet(context) ? 0.85 : 0.95),
                            height: screenHeight(context, 0.06),
                            fontSize: getDynamicFontSize(context, 16),
                            isLoading: false)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
