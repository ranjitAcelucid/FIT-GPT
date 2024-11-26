import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sales/cubit/product/diet/diet_cubit.dart';
import 'package:sales/models/product/diet_plan.dart';
import 'package:sales/utils/constants/app_style.dart';
import 'package:sales/utils/constants/colors.dart';
import 'package:sales/utils/constants/images.dart';
import 'package:sales/utils/constants/strings.dart';
import 'package:sales/utils/widgets/common_button.dart';
import 'package:sales/utils/widgets/common_input_box.dart';
import 'package:sales/utils/widgets/toast_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateNewDiet extends StatefulWidget {
  const CreateNewDiet({super.key});

  @override
  State<CreateNewDiet> createState() => _CreateNewDietState();
}

class _CreateNewDietState extends State<CreateNewDiet> {
  final TextEditingController dietName = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // List to store selected items
  List<Map<String, dynamic>> selectedMorningSnack = [];
  List<Map<String, dynamic>> selectedLunch = [];
  List<Map<String, dynamic>> selectedEveningSnack = [];
  List<Map<String, dynamic>> selectedDinner = [];

  final List<Map<String, dynamic>> foodData = [
    {
      "food_name": "Rice",
      "qty": "100g",
      "protein": 2.7,
      "kcal": 130,
      "fats": 0.3,
      "id": 1
    },
    {
      "food_name": "Wheat Flour",
      "qty": "100g",
      "protein": 12,
      "kcal": 364,
      "fats": 1.5,
      "id": 2
    },
    {
      "food_name": "Milk",
      "qty": "100g",
      "protein": 3.4,
      "kcal": 42,
      "fats": 1,
      "id": 3
    },
    {
      "food_name": "Chicken",
      "qty": "100g",
      "protein": 27,
      "kcal": 239,
      "fats": 14,
      "id": 4
    },
    {
      "food_name": "Eggs",
      "qty": "100g",
      "protein": 13,
      "kcal": 155,
      "fats": 11,
      "id": 5
    },
    {
      "food_name": "Almonds",
      "qty": "28g",
      "protein": 6,
      "kcal": 160,
      "fats": 14,
      "id": 6
    },
    {
      "food_name": "Banana",
      "qty": "118g",
      "protein": 1.3,
      "kcal": 105,
      "fats": 0.3,
      "id": 7
    },
    {
      "food_name": "Sweet Potato",
      "qty": "100g",
      "protein": 1.6,
      "kcal": 86,
      "fats": 0.1,
      "id": 8
    },
    {
      "food_name": "Paneer",
      "qty": "100g",
      "protein": 18,
      "kcal": 265,
      "fats": 20.8,
      "id": 9
    },
    {
      "food_name": "Spinach",
      "qty": "100g",
      "protein": 2.9,
      "kcal": 23,
      "fats": 0.4,
      "id": 10
    },
    {
      "food_name": "Peanuts",
      "qty": "28g",
      "protein": 7.3,
      "kcal": 161,
      "fats": 14,
      "id": 11
    },
    {
      "food_name": "Oats",
      "qty": "100g",
      "protein": 11,
      "kcal": 389,
      "fats": 6.9,
      "id": 12
    },
    {
      "food_name": "Carrots",
      "qty": "100g",
      "protein": 0.9,
      "kcal": 41,
      "fats": 0.2,
      "id": 13
    },
    {
      "food_name": "Cucumber",
      "qty": "100g",
      "protein": 0.7,
      "kcal": 16,
      "fats": 0.1,
      "id": 14
    },
    {
      "food_name": "Fish (Salmon)",
      "qty": "100g",
      "protein": 20,
      "kcal": 208,
      "fats": 13,
      "id": 15
    },
    {
      "food_name": "Lentils",
      "qty": "100g",
      "protein": 9,
      "kcal": 116,
      "fats": 0.4,
      "id": 16
    },
    {
      "food_name": "Broccoli",
      "qty": "100g",
      "protein": 2.8,
      "kcal": 34,
      "fats": 0.4,
      "id": 17
    },
    {
      "food_name": "Cottage Cheese",
      "qty": "100g",
      "protein": 11,
      "kcal": 98,
      "fats": 4.3,
      "id": 18
    },
    {
      "food_name": "Avocado",
      "qty": "100g",
      "protein": 2,
      "kcal": 160,
      "fats": 15,
      "id": 19
    },
    {
      "food_name": "Butter",
      "qty": "100g",
      "protein": 0.8,
      "kcal": 717,
      "fats": 81,
      "id": 20
    },
  ];

  // Store diet plan data
  Future<void> storeDietPlan(Map<String, dynamic> dietPlan) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Convert diet plan to JSON string
    String dietPlanJson = jsonEncode(dietPlan);

    // Save the JSON string in SharedPreferences
    await prefs.setString('diet_plan', dietPlanJson);
  }

// dialog box creating diet
  Future<void> showInputDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: const Text("Enter Diet Name"),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CommonInputBox(
                    controller: dietName,
                    hintStyle: dynamicHintStyle(context, false),
                    hintText: "Diet Name",
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(height: 10),
                  CommonButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          final Map<String, dynamic> dietData = {
                            "diet_name": dietName.text.trim(),
                            "morning_snack": selectedMorningSnack.isNotEmpty
                                ? selectedMorningSnack
                                : [],
                            "lunch":
                                selectedLunch.isNotEmpty ? selectedLunch : [],
                            "evening_snack": selectedEveningSnack.isNotEmpty
                                ? selectedEveningSnack
                                : [],
                            "dinner":
                                selectedDinner.isNotEmpty ? selectedDinner : [],
                          };
                          // Add dynamically
                          // final dietPlanCubit = DietPlanCubit();
                          // dietPlanCubit.addDietPlan(dietData);
                          await storeDietPlan(dietData);
                          ToastUtil.showToast(
                              message: "Diet plan created successfully");
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        }
                      },
                      buttonText: AppStrings.submit,
                      buttonColor: AppColors.primary,
                      buttonTextColor: AppColors.white,
                      isLoading: false),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          "Create New Diet",
          style: getDynamicTextStyle(
              context,
              headLineFontWeight500.copyWith(
                  color: AppColors.white,
                  fontSize: getDynamicFontSize(context, 16))),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      body: Stack(
        children: [
          // Full-screen container
          Container(
            width: screenWidth(context, 1),
            height: screenHeight(context, 1),
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: AppColors.dark8,
                borderRadius: BorderRadius.circular(12)),
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 70),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _commonDietTitle(
                    'Morning Snack',
                    () {
                      _showItemBottomSheet(context, "MS");
                    },
                    calculateTotalCalories('MS').toString(),
                  ),
                  SizedBox(
                    height: screenHeight(context, 0.014),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: screenWidth(context, 1),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: selectedMorningSnack.isEmpty
                        ? Text('Get energized by grabbing a morning snack 🥜',
                            style: getDynamicTextStyle(
                                context,
                                headLineFontWeight400.copyWith(
                                    fontSize: getDynamicFontSize(context, 12),
                                    color: AppColors.dark2)))
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final foodItem = selectedMorningSnack[index];
                              return ListTile(
                                title: Text(
                                  foodItem['food_name'],
                                  style: getDynamicTextStyle(
                                      context,
                                      headLineFontWeight500.copyWith(
                                          fontSize:
                                              getDynamicFontSize(context, 14),
                                          color: AppColors.dark1)),
                                ),
                                subtitle: Text(
                                  '${foodItem['qty']} | Protein: ${foodItem['protein']} | Calories: ${foodItem['kcal']} kcal | Fats: ${foodItem['fats']}',
                                  style: getDynamicTextStyle(
                                      context,
                                      headLineFontWeight400.copyWith(
                                          fontSize:
                                              getDynamicFontSize(context, 12),
                                          color: AppColors.dark4)),
                                ),
                                trailing: IconButton(
                                    onPressed: () {
                                      removeItem(foodItem, "MS");
                                      setState(() {});
                                    },
                                    icon: const Icon(Icons.close_rounded)),
                              );
                            },
                            itemCount: selectedMorningSnack.length),
                  ),
                  SizedBox(
                    height: screenHeight(context, 0.014),
                  ),
                  _commonDietTitle(
                    'Lunch',
                    () {
                      _showItemBottomSheet(context, "L");
                    },
                    calculateTotalCalories('L').toString(),
                  ),
                  SizedBox(
                    height: screenHeight(context, 0.014),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: screenWidth(context, 1),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: selectedLunch.isEmpty
                        ? Text(
                            "Don't miss lunch 📖 It's time to get a tasty meal",
                            style: getDynamicTextStyle(
                                context,
                                headLineFontWeight400.copyWith(
                                    fontSize: getDynamicFontSize(context, 12),
                                    color: AppColors.dark2)))
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final foodItem = selectedLunch[index];
                              return ListTile(
                                title: Text(
                                  foodItem['food_name'],
                                  style: getDynamicTextStyle(
                                      context,
                                      headLineFontWeight500.copyWith(
                                          fontSize:
                                              getDynamicFontSize(context, 14),
                                          color: AppColors.dark1)),
                                ),
                                subtitle: Text(
                                  '${foodItem['qty']} | Protein: ${foodItem['protein']} | Calories: ${foodItem['kcal']} kcal | Fats: ${foodItem['fats']}',
                                  style: getDynamicTextStyle(
                                      context,
                                      headLineFontWeight400.copyWith(
                                          fontSize:
                                              getDynamicFontSize(context, 12),
                                          color: AppColors.dark4)),
                                ),
                                trailing: IconButton(
                                    onPressed: () {
                                      removeItem(foodItem, "L");
                                      setState(() {});
                                    },
                                    icon: const Icon(Icons.close_rounded)),
                              );
                            },
                            itemCount: selectedLunch.length),
                  ),
                  SizedBox(
                    height: screenHeight(context, 0.014),
                  ),
                  _commonDietTitle(
                    'Evening Snack',
                    () {
                      _showItemBottomSheet(context, "ES");
                    },
                    calculateTotalCalories('ES').toString(),
                  ),
                  SizedBox(
                    height: screenHeight(context, 0.014),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: screenWidth(context, 1),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: selectedEveningSnack.isEmpty
                        ? Text(
                            "Refuel your body with a delicious evening snack 🍐",
                            style: getDynamicTextStyle(
                                context,
                                headLineFontWeight400.copyWith(
                                    fontSize: getDynamicFontSize(context, 12),
                                    color: AppColors.dark2)))
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final foodItem = selectedEveningSnack[index];
                              return ListTile(
                                title: Text(
                                  foodItem['food_name'],
                                  style: getDynamicTextStyle(
                                      context,
                                      headLineFontWeight500.copyWith(
                                          fontSize:
                                              getDynamicFontSize(context, 14),
                                          color: AppColors.dark1)),
                                ),
                                subtitle: Text(
                                  '${foodItem['qty']} | Protein: ${foodItem['protein']} | Calories: ${foodItem['kcal']} kcal | Fats: ${foodItem['fats']}',
                                  style: getDynamicTextStyle(
                                      context,
                                      headLineFontWeight400.copyWith(
                                          fontSize:
                                              getDynamicFontSize(context, 12),
                                          color: AppColors.dark4)),
                                ),
                                trailing: IconButton(
                                    onPressed: () {
                                      removeItem(foodItem, "ES");
                                      setState(() {});
                                    },
                                    icon: const Icon(Icons.close_rounded)),
                              );
                            },
                            itemCount: selectedEveningSnack.length),
                  ),
                  SizedBox(
                    height: screenHeight(context, 0.014),
                  ),
                  _commonDietTitle(
                    'Dinner',
                    () {
                      _showItemBottomSheet(context, "D");
                    },
                    calculateTotalCalories('D').toString(),
                  ),
                  SizedBox(
                    height: screenHeight(context, 0.014),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: screenWidth(context, 1),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: selectedDinner.isEmpty
                        ? Text("An early dinner can help you sleep better 🥂😴",
                            style: getDynamicTextStyle(
                                context,
                                headLineFontWeight400.copyWith(
                                    fontSize: getDynamicFontSize(context, 12),
                                    color: AppColors.dark2)))
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final foodItem = selectedDinner[index];
                              return ListTile(
                                title: Text(
                                  foodItem['food_name'],
                                  style: getDynamicTextStyle(
                                      context,
                                      headLineFontWeight500.copyWith(
                                          fontSize:
                                              getDynamicFontSize(context, 14),
                                          color: AppColors.dark1)),
                                ),
                                subtitle: Text(
                                  '${foodItem['qty']} | Protein: ${foodItem['protein']} | Calories: ${foodItem['kcal']} kcal | Fats: ${foodItem['fats']}',
                                  style: getDynamicTextStyle(
                                      context,
                                      headLineFontWeight400.copyWith(
                                          fontSize:
                                              getDynamicFontSize(context, 12),
                                          color: AppColors.dark4)),
                                ),
                                trailing: IconButton(
                                    onPressed: () {
                                      removeItem(foodItem, "D");
                                      setState(() {});
                                    },
                                    icon: const Icon(Icons.close_rounded)),
                              );
                            },
                            itemCount: selectedDinner.length),
                  ),
                  SizedBox(
                    height: screenHeight(context, 0.014),
                  ),
                ],
              ),
            ),
          ),

          // Button at the bottom
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: CommonButton(
                onPressed: () {
                  if (selectedMorningSnack.isNotEmpty ||
                      selectedLunch.isNotEmpty ||
                      selectedEveningSnack.isNotEmpty ||
                      selectedDinner.isNotEmpty) {
                    showInputDialog(context);
                  } else {
                    ToastUtil.showToast(
                        message: 'Please select item in any diet type');
                  }
                },
                buttonText: 'Create Diet',
                buttonColor: AppColors.primary,
                buttonTextColor: AppColors.white,
                height: screenHeight(context, 0.06),
                fontSize: getDynamicFontSize(context, 16),
                isLoading: false),
          ),
        ],
      ),
    );
  }

// show bottom sheet for all item
  void _showItemBottomSheet(BuildContext context, String dietType) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          height: screenHeight(context, 0.8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with title and close icon button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Select Item',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context); // Close the bottom sheet
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // List of items
              Expanded(
                child: ListView.builder(
                  itemCount: foodData.length,
                  itemBuilder: (context, index) {
                    final foodItem = foodData[index];
                    return ListTile(
                      title: Text(
                        foodItem['food_name'],
                        style: getDynamicTextStyle(
                            context,
                            headLineFontWeight500.copyWith(
                                fontSize: getDynamicFontSize(context, 14),
                                color: AppColors.dark1)),
                      ),
                      subtitle: Text(
                        '${foodItem['qty']} | Protein: ${foodItem['protein']} | Calories: ${foodItem['kcal']} kcal | Fats: ${foodItem['fats']}',
                        style: getDynamicTextStyle(
                            context,
                            headLineFontWeight400.copyWith(
                                fontSize: getDynamicFontSize(context, 12),
                                color: AppColors.dark4)),
                      ),
                      trailing: InkWell(
                        onTap: () {
                          if (dietType == "MS") {
                            // Check if the item is already selected
                            if (_isItemSelected(foodItem, "MS")) {
                              ToastUtil.showToast(
                                  message:
                                      '${foodItem['food_name']} is already selected!');
                            } else {
                              setState(() {
                                selectedMorningSnack.add(foodItem);
                              });
                              ToastUtil.showToast(message: 'Item Added');
                            }
                          } else if (dietType == "L") {
                            // Check if the item is already selected
                            if (_isItemSelected(foodItem, "L")) {
                              ToastUtil.showToast(
                                  message:
                                      '${foodItem['food_name']} is already selected!');
                            } else {
                              setState(() {
                                selectedLunch.add(foodItem);
                              });
                              ToastUtil.showToast(message: 'Item Added');
                            }
                          } else if (dietType == "ES") {
                            // Check if the item is already selected
                            if (_isItemSelected(foodItem, "ES")) {
                              ToastUtil.showToast(
                                  message:
                                      '${foodItem['food_name']} is already selected!');
                            } else {
                              setState(() {
                                selectedEveningSnack.add(foodItem);
                              });
                              ToastUtil.showToast(message: 'Item Added');
                            }
                          } else if (dietType == "D") {
                            // Check if the item is already selected
                            if (_isItemSelected(foodItem, "D")) {
                              ToastUtil.showToast(
                                  message:
                                      '${foodItem['food_name']} is already selected!');
                            } else {
                              setState(() {
                                selectedDinner.add(foodItem);
                              });
                              ToastUtil.showToast(message: 'Item Added');
                            }
                          }
                        },
                        child: Image.asset(
                          Images.add,
                          color: AppColors.primary,
                          fit: BoxFit.contain,
                          width: screenWidth(context, 0.05),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

// Check if the item already exists in the selectedItems list based on id
  bool _isItemSelected(Map<String, dynamic> item, String dietType) {
    return dietType == "MS"
        ? selectedMorningSnack
            .any((selectedItem) => selectedItem['id'] == item['id'])
        : dietType == "L"
            ? selectedLunch
                .any((selectedItem) => selectedItem['id'] == item['id'])
            : dietType == "ES"
                ? selectedEveningSnack
                    .any((selectedItem) => selectedItem['id'] == item['id'])
                : selectedDinner
                    .any((selectedItem) => selectedItem['id'] == item['id']);
  }

// remove a item
  void removeItem(Map<String, dynamic> item, String dietType) {
    if (dietType == "MS") {
      selectedMorningSnack
          .removeWhere((selectedItem) => selectedItem['id'] == item['id']);
    } else if (dietType == "L") {
      selectedLunch
          .removeWhere((selectedItem) => selectedItem['id'] == item['id']);
    } else if (dietType == "ES") {
      selectedEveningSnack
          .removeWhere((selectedItem) => selectedItem['id'] == item['id']);
    } else if (dietType == "D") {
      selectedDinner
          .removeWhere((selectedItem) => selectedItem['id'] == item['id']);
    }
  }

// calculate calories os the basis of dietType
  int calculateTotalCalories(String dietType) {
    int totalCalories = 0;

    if (dietType == "MS") {
      totalCalories = selectedMorningSnack.fold(
          0, (sum, item) => sum + (item['kcal'] as int? ?? 0));
    } else if (dietType == "L") {
      totalCalories = selectedLunch.fold(
          0, (sum, item) => sum + (item['kcal'] as int? ?? 0));
    } else if (dietType == "ES") {
      totalCalories = selectedEveningSnack.fold(
          0, (sum, item) => sum + (item['kcal'] as int? ?? 0));
    } else if (dietType == "D") {
      totalCalories = selectedDinner.fold(
          0, (sum, item) => sum + (item['kcal'] as int? ?? 0));
    }

    return totalCalories;
  }

  // common widget for diet title
  Widget _commonDietTitle(String title, void Function()? onTap, String cal) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: getDynamicTextStyle(
              context,
              headLineFontWeight600.copyWith(
                  color: AppColors.dark2,
                  fontSize: getDynamicFontSize(context, 14))),
        ),
        Row(
          children: [
            Text(
              cal != '0' ? '$cal Cal' : "",
              style: getDynamicTextStyle(
                  context,
                  headLineFontWeight400.copyWith(
                      color: AppColors.dark4,
                      fontSize: getDynamicFontSize(context, 12))),
            ),
            SizedBox(
              width: screenWidth(context, 0.02),
            ),
            InkWell(
              onTap: onTap,
              child: Image.asset(
                Images.add,
                color: AppColors.primary,
                fit: BoxFit.contain,
                width: screenWidth(context, 0.065),
              ),
            ),
          ],
        )
      ],
    );
  }
}
