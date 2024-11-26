import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sales/utils/constants/app_style.dart';
import 'package:sales/utils/constants/colors.dart';
import 'package:sales/utils/constants/images.dart';
import 'package:sales/utils/constants/strings.dart';
import 'package:sales/views/home/user/ai_diet_details.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Stream<StepCount> _stepCountStream;
  late StreamSubscription<StepCount>
      _stepCountSubscription; // StreamSubscription to handle the stream
  String _steps = '0';
  bool permissionGranted = false;
  double _distanceInKm = 0;
  double? _bmi = 0;
  double? _calories = 0;
  String aiResponse = "";
  Map<String, dynamic> dietResponseByAi = {};

  @override
  void initState() {
    super.initState();
    checkPermissionAndStartListening();
    calculateBMI();
  }

// check user permission
  Future<void> checkPermissionAndStartListening() async {
    var status = await Permission.activityRecognition.status;
    if (status.isGranted) {
      setState(() => permissionGranted = true);
      startListening();
    } else if (status.isDenied) {
      // Request permission
      var result = await Permission.activityRecognition.request();
      if (result.isGranted) {
        setState(() => permissionGranted = true);
        startListening();
      } else {
        setState(() => permissionGranted = false);
      }
    }
  }

// start listing steps using pedometer
  void startListening() {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountSubscription = _stepCountStream.listen(
      onStepCount,
      onError: onError,
    );
  }

// increasing the count of steps after listing
  void onStepCount(StepCount event) {
    setState(() {
      _steps = event.steps.toString();
      _distanceInKm = calculateDistanceInKm(event.steps);
      calculateCalories();
    });
  }

// calculate the km on the basis of steps
  double calculateDistanceInKm(int steps) {
    const double strideLengthInKm =
        0.000762; // Average stride length in kilometers
    return steps * strideLengthInKm;
  }

// error for steps listing
  void onError(error) {
    setState(() {
      _steps = 'Error reading steps';
    });
  }

// calculate user body mass
  void calculateBMI() {
    const double weight = 45;
    const double heightInCm = 172;

    if (heightInCm > 0) {
      const heightInMeters = heightInCm / 100; // Convert cm to meters
      setState(() {
        _bmi = weight / (heightInMeters * heightInMeters);
      });
    } else {
      setState(() {
        _bmi = null; // Reset BMI if input is invalid
      });
    }
  }

// get user body interpret
  String interpretBMI(double bmi) {
    if (bmi < 18.5) {
      return 'Under Weight';
    } else if (bmi < 24.9) {
      return 'Normal weight';
    } else if (bmi < 29.9) {
      return 'Overweight';
    } else {
      return 'Obesity';
    }
  }

// calculate user calories on the basis of steps and wight
  void calculateCalories() {
    final int? steps = int.tryParse(_steps);
    const double weight = 65;

    if (steps != null) {
      // Calculate calories burned per step based on weight
      double caloriesPerStep = 0.57 * weight / 1000;
      setState(() {
        _calories = steps * caloriesPerStep;
      });
    } else {
      setState(() {
        _calories = null;
      });
    }
  }

  @override
  void dispose() {
    _stepCountSubscription.cancel();
    super.dispose();
  }

  final List<Map<String, String>> dieticians = [
    {
      "name": "Sushivam Singh",
      "speciality": "Lactose-Free & Vegetarian Diets",
      "experience": "5 years of experience"
    },
    {
      "name": "Pooja",
      "speciality": "Muscle-Building Diets",
      "experience": "8 years of experience"
    },
    {
      "name": "Naveen Joshi",
      "speciality": "Plant-Based Nutrition",
      "experience": "6 years of experience"
    },
    {
      "name": "Saket Vyas",
      "speciality": "Weight-Loss Plans",
      "experience": "4 years of experience"
    }
  ];
  final List<bool> requested = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) {
          return;
        }
        await _onBackPressed();
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: AppColors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16).copyWith(top: 0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: screenWidth(context, 0.7),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.hello,
                            style: getDynamicTextStyle(
                                context,
                                headLineFontWeight400.copyWith(
                                    fontSize: getDynamicFontSize(context, 16),
                                    color: AppColors.dark3,
                                    letterSpacing: 0.5)),
                          ),
                          Text(
                            AppStrings.name,
                            style: getDynamicTextStyle(
                                context,
                                headLineFontWeight600.copyWith(
                                    fontSize: getDynamicFontSize(context, 16),
                                    color: AppColors.dark1,
                                    letterSpacing: 0.5)),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Image.asset(
                        Images.user,
                        fit: BoxFit.contain,
                        width: screenWidth(context, 0.1),
                        height: screenHeight(context, 0.1),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: screenHeight(context, 0.015),
                ),
                Container(
                  width: screenWidth(context, 1),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: AppColors.lightWhite,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.lightWhite,
                          blurRadius: 6.0,
                        ),
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.dailyProgress,
                        style: getDynamicTextStyle(
                            context,
                            headLineFontWeight500.copyWith(
                                fontSize: getDynamicFontSize(context, 15),
                                color: AppColors.dark2)),
                      ),
                      SizedBox(
                        height: screenHeight(context, 0.018),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _commonDailyProgressWidget(AppColors.maroon4,
                              Images.weight, AppStrings.weight, "65", ""),
                          SizedBox(
                            width: screenWidth(context, 0.01),
                          ),
                          _commonDailyProgressWidget(
                              AppColors.maroon1,
                              Images.bmi,
                              AppStrings.bmi,
                              _bmi!.toStringAsFixed(2),
                              interpretBMI(_bmi!)),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight(context, 0.018),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _commonDailyProgressWidget(
                              AppColors.maroon2,
                              Images.step,
                              AppStrings.steps,
                              _steps,
                              '${_distanceInKm.toStringAsFixed(2)} km'),
                          SizedBox(
                            width: screenWidth(context, 0.01),
                          ),
                          _commonDailyProgressWidget(
                              AppColors.maroon3,
                              Images.kcal,
                              AppStrings.kcal,
                              _calories!.toStringAsFixed(2),
                              ""),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: screenHeight(context, 0.03),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Our Dietician',
                    style: getDynamicTextStyle(
                        context,
                        headLineFontWeight600.copyWith(
                            color: AppColors.primary)),
                  ),
                ),
                SizedBox(
                  height: 240,
                  child: ListView.builder(
                    scrollDirection:
                        Axis.horizontal, // Make the list scroll horizontally
                    itemCount: dieticians.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final dietician = dieticians[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          width: 250, // Set a fixed width for horizontal cards
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CircleAvatar(
                                backgroundColor: Colors.green,
                                radius: 30,
                                child: Icon(Icons.person, color: Colors.white),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                dietician['name'] ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                dietician['speciality'] ?? '',
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                dietician['experience'] ?? '',
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 12),
                              ),
                              const SizedBox(height: 10),
                              requested[index]
                                  ? Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.green[100],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Text(
                                        'Requested',
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  : ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primary,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          requested[index] =
                                              true; // Update the state to show "Requested"
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  'Diet plan requested for ${dietician['name']}!')),
                                        );
                                      },
                                      child: const Text(
                                        'Request Diet Plan',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: AppColors.white),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Container(
                //   width: screenWidth(context, 1),
                //   padding: const EdgeInsets.all(10),
                //   color: AppColors.white,
                //   child: SelectableText(
                //     aiResponse,
                //     style: getDynamicTextStyle(context, headLineFontWeight400),
                //   ),
                // )
                // dietResponseByAi.isNotEmpty
                //     ? InkWell(
                //         onTap: () {
                //           Navigator.of(context).push(MaterialPageRoute(
                //             builder: (context) => AiDietDetails(
                //                 dietResponseByAi: dietResponseByAi),
                //           ));
                //         },
                //         child: Container(
                //           width: screenWidth(context, 1),
                //           padding: const EdgeInsets.all(10),
                //           decoration: BoxDecoration(
                //               color: AppColors.lightWhite1,
                //               borderRadius: BorderRadius.circular(12)),
                //           child: Column(
                //             mainAxisAlignment: MainAxisAlignment.start,
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Row(
                //                 children: [
                //                   Image.asset(
                //                     Images.aiLogo,
                //                     fit: BoxFit.contain,
                //                     color: AppColors.dark2,
                //                     width: screenWidth(context, 0.08),
                //                   ),
                //                   SizedBox(
                //                     width: screenWidth(context, 0.02),
                //                   ),
                //                   Text(
                //                     AppStrings.generateWithAi,
                //                     style: getDynamicTextStyle(
                //                         context,
                //                         headLineFontWeight500.copyWith(
                //                             fontSize:
                //                                 getDynamicFontSize(context, 14),
                //                             color: AppColors.black)),
                //                   )
                //                 ],
                //               ),
                //               SizedBox(
                //                 height: screenHeight(context, 0.015),
                //               ),
                //               Text(
                //                 '${dietResponseByAi['dietPlan']['user']['goal'].toUpperCase()} DIET FOR ${dietResponseByAi['dietPlan']['user']['age'].toString()} YEAR OLD ${dietResponseByAi['dietPlan']['user']['gender'].toUpperCase()}',
                //                 maxLines: 2,
                //                 style: getDynamicTextStyle(
                //                     context,
                //                     headLineFontWeight500.copyWith(
                //                         fontSize:
                //                             getDynamicFontSize(context, 12),
                //                         color: AppColors.dark3,
                //                         overflow: TextOverflow.ellipsis)),
                //               ),
                //               SizedBox(
                //                 height: screenHeight(context, 0.02),
                //               ),
                //               Row(
                //                 mainAxisAlignment:
                //                     MainAxisAlignment.spaceBetween,
                //                 crossAxisAlignment: CrossAxisAlignment.center,
                //                 children: [
                //                   SizedBox(
                //                     width: screenWidth(context, 0.4),
                //                     child: Row(
                //                       mainAxisAlignment:
                //                           MainAxisAlignment.start,
                //                       crossAxisAlignment:
                //                           CrossAxisAlignment.center,
                //                       children: [
                //                         Container(
                //                           width: screenHeight(context, 0.05),
                //                           height: screenHeight(context, 0.05),
                //                           decoration: BoxDecoration(
                //                               color: AppColors.primary,
                //                               borderRadius:
                //                                   BorderRadius.circular(
                //                                       screenHeight(
                //                                           context, 0.03))),
                //                           child: Center(
                //                             child: Image.asset(
                //                               Images.weight1,
                //                               fit: BoxFit.contain,
                //                               color: AppColors.white,
                //                               width: screenWidth(context, 0.05),
                //                             ),
                //                           ),
                //                         ),
                //                         SizedBox(
                //                           width: screenWidth(context, 0.02),
                //                         ),
                //                         Text(
                //                           '${dietResponseByAi['dietPlan']['user']['weight'].toString()} KG',
                //                           style: getDynamicTextStyle(
                //                               context,
                //                               headLineFontWeight500.copyWith(
                //                                   fontSize: getDynamicFontSize(
                //                                     context,
                //                                     16,
                //                                   ),
                //                                   color: AppColors.dark3)),
                //                         )
                //                       ],
                //                     ),
                //                   ),
                //                   SizedBox(
                //                     width: screenWidth(context, 0.4),
                //                     child: Row(
                //                       mainAxisAlignment:
                //                           MainAxisAlignment.start,
                //                       crossAxisAlignment:
                //                           CrossAxisAlignment.center,
                //                       children: [
                //                         Container(
                //                           width: screenHeight(context, 0.05),
                //                           height: screenHeight(context, 0.05),
                //                           decoration: BoxDecoration(
                //                               color: AppColors.yellow,
                //                               borderRadius:
                //                                   BorderRadius.circular(
                //                                       screenHeight(
                //                                           context, 0.03))),
                //                           child: Center(
                //                             child: Image.asset(
                //                               Images.height,
                //                               fit: BoxFit.contain,
                //                               color: AppColors.white,
                //                               width: screenWidth(context, 0.05),
                //                             ),
                //                           ),
                //                         ),
                //                         SizedBox(
                //                           width: screenWidth(context, 0.02),
                //                         ),
                //                         Text(
                //                           '${dietResponseByAi['dietPlan']['user']['height']} CM',
                //                           style: getDynamicTextStyle(
                //                               context,
                //                               headLineFontWeight500.copyWith(
                //                                   fontSize: getDynamicFontSize(
                //                                     context,
                //                                     16,
                //                                   ),
                //                                   color: AppColors.dark3)),
                //                         )
                //                       ],
                //                     ),
                //                   ),
                //                 ],
                //               )
                //             ],
                //           ),
                //         ),
                //       )
                //     : const SizedBox()
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.shadeGreen1,
          onPressed: () async {
            showLoading(context);
            try {
              final model = GenerativeModel(
                model: 'gemini-1.5-flash-latest',
                apiKey: "AIzaSyDtwQ3KVLoecIP6Ro9TcBF0huJbWbSaA3U",
              );

              const prompt =
                  "Generate a one-day lactose-free vegetarian Indian diet plan in JSON format. The user is male, 25 years old, weighs 65 kg, is 172 cm tall, and user aims to fat loss. Include meal timings and specific food items for breakfast, mid-morning snack, lunch, evening snack, dinner, and a post-dinner snack. And also don't change the response format keep it it one";
              final content = [Content.text(prompt)];
              final response = await model.generateContent(content);
              String aiContent = response.text ?? "";
              // Remove the "json" keyword from the beginning
              // final cleanedString = aiContent.replaceFirst('json', '').trim();
              // final startIndex = aiContent.indexOf('{');
              // final cleanedString = aiContent.substring(startIndex);
              final cleanedString = aiContent
                  .replaceAll('```', '') // Remove triple backticks
                  .replaceFirst(RegExp(r'^.*?\{'),
                      '{') // Remove anything before the first '{'
                  .trim()
                  .replaceFirst('json', "")
                  .trim();
              setState(() {
                dietResponseByAi = json.decode(cleanedString);
                aiResponse = cleanedString;
              });

              if (context.mounted) {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AiDietDetails(
                      dietResponseByAi: json.decode(cleanedString)),
                ));
              }
            } catch (e) {
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            }
          },
          child: Image.asset(
            Images.ai,
            color: AppColors.primary,
            fit: BoxFit.contain,
            width: screenWidth(context, 0.08),
          ),
        ),
      ),
    );
  }

// daily progress widget
  Widget _commonDailyProgressWidget(
      Color color, String image, String title, String value, String subValue) {
    return Container(
      width: screenWidth(context, 0.4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: AppColors.dark8,
              blurRadius: 2.0,
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            image,
            fit: BoxFit.contain,
            width: screenWidth(context, 0.1),
          ),
          SizedBox(
            height: screenHeight(context, 0.01),
          ),
          Center(
            child: RichText(
              text: TextSpan(
                text: title,
                style: getDynamicTextStyle(
                  context,
                  headLineFontWeight400.copyWith(
                      fontSize: getDynamicFontSize(context, 14),
                      color: AppColors.dark4),
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: ' $value',
                      style: getDynamicTextStyle(
                          context,
                          headLineFontWeight500.copyWith(
                              fontSize: getDynamicFontSize(context, 18),
                              color: AppColors.dark1))),
                ],
              ),
            ),
          ),
          SizedBox(
            height: screenHeight(context, 0.002),
          ),
          subValue.isNotEmpty
              ? Text(
                  subValue,
                  style: getDynamicTextStyle(
                      context,
                      headLineFontWeight400.copyWith(
                          fontSize: getDynamicFontSize(context, 12),
                          color: AppColors.dark3)),
                )
              : const SizedBox()
        ],
      ),
    );
  }

// loading model
  static void showLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SpinKitThreeBounce(
              color: AppColors.white,
              size: 30,
            ),
            Text(
              'Generating ...',
              style: getDynamicTextStyle(
                  context,
                  headLineFontWeight400.copyWith(
                      color: AppColors.white,
                      fontSize: getDynamicFontSize(context, 16),
                      decoration: TextDecoration.none)),
            )
          ],
        );
      },
    );
  }

  /// back pressed modal
  Future<bool> _onBackPressed() async {
    return (await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit the app?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  exit(0);
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false; // Provide a default value of 'false' if null is returned
  }
}
