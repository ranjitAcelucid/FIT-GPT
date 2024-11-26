import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales/cubit/product/diet/diet_cubit.dart';
import 'package:sales/cubit/product/diet/diet_state.dart';
import 'package:sales/utils/constants/app_style.dart';
import 'package:sales/utils/constants/colors.dart';
import 'package:sales/utils/constants/images.dart';
import 'package:sales/utils/constants/strings.dart';
import 'package:sales/utils/widgets/common_button.dart';
import 'package:sales/views/home/dietician/create_new_diet.dart';
import 'package:sales/views/home/dietician/user_list.dart';

class DieticianHome extends StatefulWidget {
  const DieticianHome({super.key});

  @override
  State<DieticianHome> createState() => _DieticianHomeState();
}

class _DieticianHomeState extends State<DieticianHome> {
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
          padding: const EdgeInsets.all(16.0).copyWith(top: 0),
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
                    onTap: () {
                      // After returning, refresh the diet plans
                      context.read<DietPlanCubit>().fetchDietPlans();
                      setState(() {});
                    },
                    child: Image.asset(
                      Images.addUser,
                      fit: BoxFit.contain,
                      width: screenWidth(context, 0.1),
                      height: screenHeight(context, 0.1),
                    ),
                  )
                ],
              ),
              BlocBuilder<DietPlanCubit, DietPlanState>(
                builder: (context, state) {
                  if (state is DietPlanLoaded) {
                    if (state.dietPlans.isNotEmpty) {
                      return ListView.builder(
                        itemCount: state.dietPlans.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final dietPlan = state.dietPlans[index];
                          return ListTile(
                            title: Text(dietPlan.dietName),
                          );
                        },
                      );
                    } else {
                      return _buildNoDietAvailable(context);
                    }
                  }
                  return const SizedBox(); // Placeholder for other states or loading.
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  // Widget for "No Diet" UI
  Widget _buildNoDietAvailable(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: screenHeight(context, 0.15)),
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
                    // Refresh data after returning
                    context.read<DietPlanCubit>().fetchDietPlans();
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
