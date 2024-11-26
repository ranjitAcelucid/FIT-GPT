import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:sales/utils/common/general_function.dart';
import 'package:sales/utils/constants/app_style.dart';
import 'package:sales/utils/constants/colors.dart';
import 'package:sales/utils/constants/images.dart';
import 'package:sales/utils/constants/regex.dart';
import 'package:sales/utils/constants/responsive.dart';
import 'package:sales/utils/constants/strings.dart';
import 'package:sales/utils/widgets/common_button.dart';
import 'package:sales/utils/widgets/common_input_box.dart';
import 'package:sales/views/auth/sign_up.dart';
import 'package:sales/views/home/user/home.dart';

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

  sendEmail(BuildContext context //For showing snackbar
      ) async {
    String username = 'ranjit.kumar@acelucid.com'; //Your Email
    String password =
        "szbeqyevznwksshy"; // 16 Digits App Password Generated From Google Account

    final smtpServer = gmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    final message = Message()
          ..from = Address(username, 'Test')
          ..recipients.add('ranjitrahi2@gmail.com')
          // ..ccRecipients.addAll(['abc@gmail.com', 'xyz@gmail.com']) // For Adding Multiple Recipients
          // ..bccRecipients.add(Address('a@gmail.com')) For Binding Carbon Copy of Sent Email
          ..subject = 'Mail from Mailer'
          ..text = 'Hello dear, I am sending you email from Flutter application'
        // ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>"; // For Adding Html in email
        // ..attachments = [
        //   FileAttachment(File('image.png'))  //For Adding Attachments
        //     ..location = Location.inline
        //     ..cid = '<myimg@3.141>'
        // ]
        ;

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: $sendReport');
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Mail Send Successfully")));
    } on MailerException catch (e) {
      print('Message not sent.');
      print(e.message);
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Image background
          SizedBox.expand(
            child: Image.asset(
              Images.bgImg,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: screenHeight(context, 0.015),
              ),
              Form(
                key: _formKey,
                child: Center(
                  child: Container(
                    width: screenWidth(
                        context, Responsive.isTablet(context) ? 0.85 : 0.95),
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                        color: Colors.transparent.withOpacity(0.3),
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
                          minLines: 1,
                          maxLines: 10,
                          // prefixIcon: GeneralFunction()
                          //     .commonSvgIcon(Images.email, context, true),
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
                          hintStyle: dynamicHintStyle(context, true),
                          hintText: AppStrings.password,
                          textInputAction: TextInputAction.done,
                          obscureText: _passwordVisible,
                          keyboardType: TextInputType.visiblePassword,
                          // prefixIcon: GeneralFunction()
                          //     .commonSvgIcon(Images.password, context, true),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                            child: GeneralFunction().commonSvgIcon(
                                Images.eye, context, _passwordVisible),
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
                                    scale: Responsive.isMobile(context)
                                        ? 1.2
                                        : 1.8,
                                    child: Checkbox(
                                      value: rememberMe,
                                      activeColor: AppColors.primary,
                                      side: const BorderSide(
                                          width: 1.5, color: AppColors.dark9),
                                      onChanged: (value) {
                                        setState(() {
                                          rememberMe = value!;
                                        });
                                      },
                                    )),
                                SizedBox(
                                  width: Responsive.isMobile(context)
                                      ? MediaQuery.of(context).size.width *
                                          0.005
                                      : MediaQuery.of(context).size.width *
                                          0.02,
                                ),
                                Text(AppStrings.rememberMe,
                                    style: getDynamicTextStyle(
                                        context,
                                        headLineFontWeight400.copyWith(
                                          color: AppColors.dark9,
                                          fontSize: Responsive.isMobile(context)
                                              ? 14
                                              : 12,
                                        )))
                              ],
                            ),
                            // InkWell(
                            //   onTap: () {},
                            //   child: Ink(
                            //     child: Text(
                            //       AppStrings.forgotPassword,
                            //       style: getDynamicTextStyle(
                            //           context,
                            //           headLineFontWeight500.copyWith(
                            //               fontSize: Responsive.isMobile(context)
                            //                   ? 12
                            //                   : 10,
                            //               color: AppColors.secondary7,
                            //               letterSpacing: 0.4,
                            //               fontWeight: FontWeight.w500,
                            //               // decoration: TextDecoration.underline,
                            //               decorationColor: AppColors.primary)),
                            //     ),
                            //   ),
                            // )
                          ],
                        ),
                        SizedBox(height: screenHeight(context, 0.05)),
                        CommonButton(
                            width: screenWidth(context,
                                Responsive.isTablet(context) ? 0.85 : 0.95),
                            height: screenHeight(context, 0.06),
                            onPressed: () async {
                              // sendEmail(context);
                              if (_formKey.currentState!.validate()) {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const Home(),
                                ));
                              }

                              // final model = GenerativeModel(
                              //   model: 'gemini-1.5-flash-latest',
                              //   apiKey: "AIzaSyDtwQ3KVLoecIP6Ro9TcBF0huJbWbSaA3U",
                              // );

                              // const prompt =
                              //     'create a diet plan for me my age: 22 weight : 75 height:5.11 dietary preference vegetarian and i am lactose intolerant and am idian diet goal is muscle building';
                              // final content = [Content.text(prompt)];
                              // final response = await model.generateContent(content);
                              // setState(() {
                              //   emailController.text = response.text!;
                              // });

                              // print("response==> ${response.text}");
                            },
                            buttonText: AppStrings.signIn,
                            buttonColor: AppColors.primary,
                            buttonTextColor: AppColors.white,
                            fontSize: getDynamicFontSize(context, 16),
                            isLoading: false),
                        SizedBox(height: screenHeight(context, 0.02)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              AppStrings.dontHaveAnAccount,
                              style: getDynamicTextStyle(
                                  context,
                                  headLineFontWeight400.copyWith(
                                      fontSize: getDynamicFontSize(context, 14),
                                      color: AppColors.dark3)),
                            ),
                            TextButton(
                                onPressed: () {
                                  _showRoleSelectionBottomSheet(context);
                                },
                                child: Text(
                                  AppStrings.signUp,
                                  style: getDynamicTextStyle(
                                      context,
                                      headLineFontWeight500.copyWith(
                                          fontSize:
                                              getDynamicFontSize(context, 14),
                                          color: AppColors.dark9)),
                                ))
                          ],
                        )
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

// user role sheet
  void _showRoleSelectionBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Choose Your Role",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildRoleCard(
                    context,
                    "User",
                    Icons.person,
                    Colors.blue.shade100,
                    Colors.blue,
                    () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SignUp(
                          isUser: true,
                        ),
                      ));
                    },
                  ),
                  _buildRoleCard(
                    context,
                    "Dietician",
                    Icons.medical_services,
                    Colors.green.shade100,
                    Colors.green,
                    () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SignUp(
                          isUser: false,
                        ),
                      ));
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

// card
  Widget _buildRoleCard(BuildContext context, String role, IconData icon,
      Color backgroundColor, Color iconColor, void Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 130,
        height: 150,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: iconColor),
            const SizedBox(height: 10),
            Text(
              role,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: iconColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
