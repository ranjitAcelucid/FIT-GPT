import 'package:flutter/material.dart';
import 'package:sales/utils/constants/app_style.dart';
import 'package:sales/utils/constants/colors.dart';
import 'package:sales/utils/constants/strings.dart';
import 'package:sales/utils/widgets/common_button.dart';
import 'package:sales/utils/widgets/common_input_box.dart';
import 'package:sales/views/home/dietician/dietician_home.dart';
import 'package:sales/views/home/user/home.dart';

class BasicDetails extends StatefulWidget {
  final bool isUser;
  const BasicDetails({super.key, required this.isUser});

  @override
  State<BasicDetails> createState() => _BasicDetailsState();
}

class _BasicDetailsState extends State<BasicDetails> {
  int currentIndex = 0;
  List stepCount = [1, 2, 3];
  TextEditingController fullName = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController dietaryPreference = TextEditingController();
  TextEditingController healthCondition = TextEditingController();
  TextEditingController goal = TextEditingController();
  TextEditingController aboutYourself = TextEditingController();
  TextEditingController experience = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: AppColors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: screenWidth(context, 0.53),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.arrow_back)),
                    // SizedBox(
                    //   height: 10,
                    //   child: ListView.separated(
                    //       shrinkWrap: true,
                    //       scrollDirection: Axis.horizontal,
                    //       itemBuilder: (context, index) {
                    //         return Container(
                    //           width: currentIndex == index ? 20 : 10,
                    //           height: 10,
                    //           decoration: BoxDecoration(
                    //               color: currentIndex == index
                    //                   ? AppColors.primary
                    //                   : AppColors.dark4,
                    //               borderRadius: BorderRadius.circular(5)),
                    //         );
                    //       },
                    //       separatorBuilder: (context, index) {
                    //         return SizedBox(
                    //           width: screenWidth(context, 0.014),
                    //         );
                    //       },
                    //       itemCount: stepCount.length),
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight(context, 0.0),
              ),
              Center(
                  child: Text(
                AppStrings.knowYouBetter,
                style: getDynamicTextStyle(
                    context,
                    headLineFontWeight500.copyWith(
                        color: AppColors.dark2,
                        fontSize: getDynamicFontSize(context, 18))),
              )),
              SizedBox(
                height: screenHeight(context, 0.03),
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonInputBox(
                      controller: fullName,
                      hintStyle: dynamicHintStyle(context, false),
                      hintText: AppStrings.fullName,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(
                      height: screenHeight(context, 0.015),
                    ),
                    CommonInputBox(
                      controller: gender,
                      readOnly: true,
                      hintStyle: dynamicHintStyle(context, false),
                      hintText: AppStrings.gender,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      suffixIcon: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          icon: const Icon(Icons.arrow_drop_down),
                          items: <String>['Male', 'Female'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              gender.text = newValue ?? "";
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight(context, 0.015),
                    ),
                    CommonInputBox(
                      controller: age,
                      hintStyle: dynamicHintStyle(context, false),
                      hintText: AppStrings.age,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      maxLength: 3,
                    ),
                    SizedBox(
                      height: screenHeight(context, 0.015),
                    ),
                    widget.isUser
                        ? CommonInputBox(
                            controller: height,
                            hintStyle: dynamicHintStyle(context, false),
                            hintText: AppStrings.height,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            overrideValidator: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppStrings.thisFieldRequired;
                              }
                              final height = double.tryParse(value);
                              if (height == null) {
                                return AppStrings.thisFieldRequired;
                              }
                              if (height < 50 || height > 300) {
                                return 'Height must be between 50 cm and 300 cm';
                              }
                              return null;
                            },
                          )
                        : CommonInputBox(
                            controller: aboutYourself,
                            hintStyle: dynamicHintStyle(context, false),
                            hintText: AppStrings.aboutYourself,
                            textInputAction: TextInputAction.next,
                            minLines: 3,
                            maxLines: 5,
                          ),
                    SizedBox(
                      height: screenHeight(context, 0.015),
                    ),
                    widget.isUser
                        ? CommonInputBox(
                            controller: weight,
                            hintStyle: dynamicHintStyle(context, false),
                            hintText: AppStrings.weight1,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            maxLength: 3,
                          )
                        : CommonInputBox(
                            controller: experience,
                            hintStyle: dynamicHintStyle(context, false),
                            hintText: AppStrings.experience,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            maxLength: 2,
                          ),
                    SizedBox(
                      height: screenHeight(context, 0.015),
                    ),
                    widget.isUser
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonInputBox(
                                controller: goal,
                                readOnly: true,
                                hintStyle: dynamicHintStyle(context, false),
                                hintText: AppStrings.goal,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                suffixIcon: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    icon: const Icon(Icons.arrow_drop_down),
                                    items: <String>[
                                      'Musle Building',
                                      'Fat Loss',
                                    ].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        goal.text = newValue ?? "";
                                      });
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: screenHeight(context, 0.015),
                              ),
                              CommonInputBox(
                                controller: dietaryPreference,
                                readOnly: true,
                                hintStyle: dynamicHintStyle(context, false),
                                hintText: AppStrings.dietaryPrefs,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                suffixIcon: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    icon: const Icon(Icons.arrow_drop_down),
                                    items: <String>[
                                      'Vegan',
                                      'Pure Vegetarian',
                                      'Ovo Vegetarian',
                                      'Non Vegetarian'
                                    ].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dietaryPreference.text = newValue ?? "";
                                      });
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: screenHeight(context, 0.015),
                              ),
                              CommonInputBox(
                                controller: healthCondition,
                                readOnly: true,
                                hintStyle: dynamicHintStyle(context, false),
                                hintText: AppStrings.healthCondition,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.done,
                                suffixIcon: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    icon: const Icon(Icons.arrow_drop_down),
                                    items: <String>[
                                      'No Medical Condition',
                                      'Thyroid',
                                      'Diabetes / Pre-Diebetes',
                                      'PCOD / PCOS',
                                      'Cholesterol'
                                    ].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        healthCondition.text = newValue ?? "";
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        height: 150,
        color: AppColors.whiteSmoke,
        child: Column(
          children: [
            Text(
              AppStrings.signUpInfo,
              textAlign: TextAlign.center,
              style: getDynamicTextStyle(
                  context,
                  headLineFontWeight400.copyWith(
                      color: AppColors.dark3,
                      fontSize: getDynamicFontSize(context, 12))),
            ),
            SizedBox(
              height: screenHeight(context, 0.016),
            ),
            CommonButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (widget.isUser) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Home(),
                      ));
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const DieticianHome(),
                      ));
                    }
                  }
                },
                height: screenHeight(context, 0.05),
                width: screenWidth(context, 1),
                buttonText: AppStrings.submit,
                buttonColor: AppColors.primary,
                buttonTextColor: AppColors.white,
                isLoading: false),
          ],
        ),
      ),
    );
  }
}
