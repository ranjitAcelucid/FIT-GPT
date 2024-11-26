import 'package:flutter/material.dart';
import 'package:sales/utils/constants/app_style.dart';
import 'package:sales/utils/constants/colors.dart';
import 'package:sales/utils/constants/images.dart';
import 'package:sales/utils/constants/strings.dart';

class AiDietDetails extends StatefulWidget {
  final Map<String, dynamic> dietResponseByAi;
  const AiDietDetails({super.key, required this.dietResponseByAi});

  @override
  State<AiDietDetails> createState() => _AiDietDetailsState();
}

class _AiDietDetailsState extends State<AiDietDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.generateWithAi,
          maxLines: 2,
          style: getDynamicTextStyle(
              context,
              headLineFontWeight400.copyWith(
                  fontSize: getDynamicFontSize(context, 16),
                  color: AppColors.white)),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 248, 246, 243),
              borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: screenWidth(context, 0.4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: screenHeight(context, 0.05),
                          height: screenHeight(context, 0.05),
                          decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(
                                  screenHeight(context, 0.03))),
                          child: Center(
                            child: Image.asset(
                              Images.weight1,
                              fit: BoxFit.contain,
                              color: AppColors.white,
                              width: screenWidth(context, 0.05),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth(context, 0.02),
                        ),
                        Text(
                          '${widget.dietResponseByAi['dietPlan']['user']['weight'].toString()} KG',
                          style: getDynamicTextStyle(
                              context,
                              headLineFontWeight500.copyWith(
                                  fontSize: getDynamicFontSize(
                                    context,
                                    15,
                                  ),
                                  color: AppColors.dark3)),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: screenWidth(context, 0.4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: screenHeight(context, 0.05),
                          height: screenHeight(context, 0.05),
                          decoration: BoxDecoration(
                              color: AppColors.yellow,
                              borderRadius: BorderRadius.circular(
                                  screenHeight(context, 0.03))),
                          child: Center(
                            child: Image.asset(
                              Images.height,
                              fit: BoxFit.contain,
                              color: AppColors.white,
                              width: screenWidth(context, 0.05),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth(context, 0.02),
                        ),
                        Text(
                          '${widget.dietResponseByAi['dietPlan']['user']['height']} CM',
                          style: getDynamicTextStyle(
                              context,
                              headLineFontWeight500.copyWith(
                                  fontSize: getDynamicFontSize(
                                    context,
                                    15,
                                  ),
                                  color: AppColors.dark3)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight(context, 0.024),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: screenWidth(context, 0.4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: screenHeight(context, 0.05),
                          height: screenHeight(context, 0.05),
                          decoration: BoxDecoration(
                              color: AppColors.maroon,
                              borderRadius: BorderRadius.circular(
                                  screenHeight(context, 0.03))),
                          child: Center(
                            child: Image.asset(
                              Images.age,
                              fit: BoxFit.contain,
                              color: AppColors.white,
                              width: screenWidth(context, 0.05),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth(context, 0.02),
                        ),
                        Text(
                          '${widget.dietResponseByAi['dietPlan']['user']['age'].toString()} year old',
                          style: getDynamicTextStyle(
                              context,
                              headLineFontWeight500.copyWith(
                                  fontSize: getDynamicFontSize(
                                    context,
                                    15,
                                  ),
                                  color: AppColors.dark3)),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: screenWidth(context, 0.4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: screenHeight(context, 0.05),
                          height: screenHeight(context, 0.05),
                          decoration: BoxDecoration(
                              color: AppColors.smalt,
                              borderRadius: BorderRadius.circular(
                                  screenHeight(context, 0.03))),
                          child: Center(
                            child: Image.asset(
                              Images.gender,
                              fit: BoxFit.contain,
                              color: AppColors.white,
                              width: screenWidth(context, 0.05),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth(context, 0.02),
                        ),
                        Text(
                          '${widget.dietResponseByAi['dietPlan']['user']['gender'].toUpperCase()}',
                          style: getDynamicTextStyle(
                              context,
                              headLineFontWeight500.copyWith(
                                  fontSize: getDynamicFontSize(
                                    context,
                                    15,
                                  ),
                                  color: AppColors.dark3)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight(context, 0.024),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: screenWidth(context, 0.4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: screenHeight(context, 0.05),
                          height: screenHeight(context, 0.05),
                          decoration: BoxDecoration(
                              color: const Color(0xff5F374B),
                              borderRadius: BorderRadius.circular(
                                  screenHeight(context, 0.03))),
                          child: Center(
                            child: Image.asset(
                              Images.target,
                              fit: BoxFit.contain,
                              color: AppColors.white,
                              width: screenWidth(context, 0.05),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth(context, 0.02),
                        ),
                        Text(
                          widget.dietResponseByAi['dietPlan']['user']['goal']
                              .toUpperCase(),
                          style: getDynamicTextStyle(
                              context,
                              headLineFontWeight500.copyWith(
                                  fontSize: getDynamicFontSize(
                                    context,
                                    15,
                                  ),
                                  color: AppColors.dark3)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight(context, 0.018),
              ),
              const Divider(
                color: AppColors.lightGrey,
              ),
              SizedBox(
                height: screenHeight(context, 0.018),
              ),
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              index == 0
                                  ? Images.breakfast
                                  : index == 1
                                      ? Images.midMngSnk
                                      : index == 2
                                          ? Images.lunch
                                          : index == 3
                                              ? Images.snackEvn
                                              : index == 4
                                                  ? Images.dinner
                                                  : Images.dinnerSnk,
                              fit: BoxFit.contain,
                              width: screenWidth(context, 0.06),
                            ),
                            SizedBox(
                              width: screenWidth(context, 0.02),
                            ),
                            Text(
                              widget.dietResponseByAi['dietPlan']['meals']
                                  [index]['meal'],
                              style: getDynamicTextStyle(
                                  context,
                                  headLineFontWeight500.copyWith(
                                      fontSize: getDynamicFontSize(context, 14),
                                      color: AppColors.dark1)),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 32),
                          child: ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, subIndex) {
                                return Row(
                                  children: [
                                    Image.asset(
                                      Images.point,
                                      fit: BoxFit.contain,
                                      width: screenWidth(context, 0.04),
                                    ),
                                    SizedBox(
                                      width: screenWidth(context, 0.02),
                                    ),
                                    Flexible(
                                      child: Text(
                                        widget.dietResponseByAi['dietPlan']
                                            ['meals'][index]['items'][subIndex],
                                        style: getDynamicTextStyle(
                                            context,
                                            headLineFontWeight400.copyWith(
                                                fontSize: getDynamicFontSize(
                                                    context, 12),
                                                color: AppColors.dark4)),
                                      ),
                                    ),
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: screenHeight(context, 0.012),
                                );
                              },
                              itemCount: widget
                                  .dietResponseByAi['dietPlan']['meals'][index]
                                      ['items']
                                  .length),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: screenHeight(context, 0.018),
                    );
                  },
                  itemCount:
                      widget.dietResponseByAi['dietPlan']['meals'].length),
              SizedBox(
                height: screenHeight(context, 0.025),
              ),
              RichText(
                text: TextSpan(
                  text: "Note:",
                  style: getDynamicTextStyle(
                    context,
                    headLineFontWeight500.copyWith(
                        fontSize: getDynamicFontSize(context, 14),
                        color: AppColors.shadeRed),
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text:
                            ' ${widget.dietResponseByAi['dietPlan']['notes']}:',
                        style: getDynamicTextStyle(
                            context,
                            headLineFontWeight400.copyWith(
                                fontSize: getDynamicFontSize(context, 12),
                                color: AppColors.dark1))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
