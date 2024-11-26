import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sales/models/product/diet_plan.dart';
import 'package:sales/utils/constants/app_style.dart';
import 'package:sales/utils/constants/colors.dart';
import 'package:sales/utils/constants/images.dart';
import 'package:sales/utils/constants/strings.dart';
import 'package:sales/utils/widgets/common_button.dart';
import 'package:sales/utils/widgets/toast_util.dart';
import 'package:sales/views/auth/login.dart';
import 'package:sales/views/home/dietician/create_new_diet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DieticianHome extends StatefulWidget {
  const DieticianHome({super.key});

  @override
  State<DieticianHome> createState() => _DieticianHomeState();
}

class _DieticianHomeState extends State<DieticianHome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retrieveDietPlan();
  }

  // Retrieve diet plan data
  Future<DietPlan?> retrieveDietPlan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? dietPlanJson = prefs.getString('diet_plan');

    if (dietPlanJson != null) {
      Map<String, dynamic> dietPlanMap = jsonDecode(dietPlanJson);
      return DietPlan.fromJson(dietPlanMap);
    }

    return null; // Return null if no data found
  }

  Future<DietPlan?> getDietPlan() async {
    return await retrieveDietPlan();
  }

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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0).copyWith(bottom: 0),
                child: Row(
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
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const Login()),
                              (Route route) => false);
                        },
                        child: Text(
                          'Logout',
                          style: getDynamicTextStyle(
                              context,
                              headLineFontWeight500.copyWith(
                                  color: AppColors.shadeRed)),
                        ))
                  ],
                ),
              ),
              FutureBuilder<DietPlan?>(
                future: getDietPlan(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData) {
                    return _buildNoDietAvailable(context);
                  } else {
                    DietPlan dietPlan = snapshot.data!;

                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),

                          // Main Diet Plan Card
                          Card(
                            color: AppColors
                                .dark9, // Light background color for the card
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Display diet name
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Text(
                                      'Diet Name: ${dietPlan.dietName}',
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  // Morning Snack
                                  buildMealSection(
                                    'Morning Snack',
                                    dietPlan.morningSnack,
                                    Icons.breakfast_dining,
                                    Colors.orange,
                                  ),
                                  const SizedBox(height: 10),

                                  // Lunch
                                  buildMealSection(
                                    'Lunch',
                                    dietPlan.lunch,
                                    Icons.lunch_dining,
                                    Colors.green,
                                  ),
                                  const SizedBox(height: 10),

                                  // Evening Snack
                                  buildMealSection(
                                    'Evening Snack',
                                    dietPlan.eveningSnack,
                                    Icons.nightlight_round,
                                    Colors.blue,
                                  ),
                                  const SizedBox(height: 10),

                                  // Dinner
                                  buildMealSection(
                                    'Dinner',
                                    dietPlan.dinner,
                                    Icons.dinner_dining,
                                    Colors.purple,
                                  ),
                                  const SizedBox(height: 10),
                                  Center(
                                    child: CommonButton(
                                      onPressed: () {
                                        ToastUtil.showToast(
                                            message: 'Currently no users');
                                      },
                                      buttonText: 'Assign Diet',
                                      buttonColor: AppColors.matterhorn,
                                      buttonTextColor: AppColors.white,
                                      isLoading: false,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
              CommonButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                    builder: (context) => const CreateNewDiet(),
                  ))
                      .then(
                    (value) {
                      retrieveDietPlan();
                      getDietPlan();
                      setState(() {});
                    },
                  );
                },
                buttonText: 'Create New Diet',
                buttonColor: AppColors.primary,
                buttonTextColor: AppColors.white,
                isLoading: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for "No Diet" UI
  Widget _buildNoDietAvailable(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(top: screenHeight(context, 0.15)),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              Images.noDiet,
              fit: BoxFit.contain,
              width: screenWidth(context, 0.7),
            ),
            Text(
              AppStrings.noDietInfo,
              textAlign: TextAlign.center,
              style: getDynamicTextStyle(
                context,
                headLineFontWeight400.copyWith(
                  color: AppColors.dark6,
                  fontSize: getDynamicFontSize(context, 13),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight(context, 0.018),
            ),
            CommonButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                  builder: (context) => const CreateNewDiet(),
                ))
                    .then(
                  (value) {
                    retrieveDietPlan();
                    getDietPlan();
                    setState(() {});
                  },
                );
              },
              buttonText: 'Create New Diet',
              buttonColor: AppColors.primary,
              buttonTextColor: AppColors.white,
              isLoading: false,
            ),
          ],
        ),
      ),
    );
  }

  // Method to build each meal section (morning snack, lunch, evening snack, dinner)
  Widget buildMealSection(String title, List<Map<String, dynamic>> foodItems,
      IconData icon, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 30, color: color),
            const SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold, color: color),
            ),
          ],
        ),
        const SizedBox(height: 15),
        // List all the food items for this meal
        foodItems.isNotEmpty
            ? Column(
                children: foodItems.map((food) {
                  return ListTile(
                    leading: Icon(Icons.food_bank, color: color),
                    title: Text(food['food_name']),
                    subtitle: Text(
                        'Qty: ${food['qty']}, Protein: ${food['protein']}g, Calories: ${food['kcal']} kcal'),
                  );
                }).toList(),
              )
            : Text(
                'No Item Assigned',
                style: getDynamicTextStyle(
                    context,
                    headLineFontWeight500.copyWith(
                        fontSize: getDynamicFontSize(context, 14),
                        color: AppColors.dark6)),
              ),
      ],
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
