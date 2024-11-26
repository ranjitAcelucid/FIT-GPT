import 'package:flutter/material.dart';
import 'package:sales/utils/constants/app_style.dart';
import 'package:sales/utils/constants/colors.dart';
import 'package:sales/utils/constants/strings.dart';

class UserList extends StatelessWidget {
  final List<Map<String, dynamic>> users = [
    {
      'id': 1,
      'name': 'John Doe',
      'age': 28,
      'height': "173",
      'weight': '75 kg',
      'goal': 'Weight Loss',
      'healthCondition': 'Diabetic',
      'dietPreference': 'Vegan',
    },
    {
      'id': 2,
      'name': 'Jane Smith',
      'age': 34,
      'height': "167",
      'weight': '62 kg',
      'goal': 'Muscle Gain',
      'healthCondition': 'Lactose Intolerant',
      'dietPreference': 'Pure Vegetarian',
    },
    {
      'id': 3,
      'name': 'Alice Johnson',
      'age': 25,
      'height': "188",
      'weight': '68 kg',
      'goal': 'General Fitness',
      'healthCondition': 'None',
      'dietPreference': 'Non-Vegetarian',
    },
  ];

  UserList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.dietPlanReq,
          style: getDynamicTextStyle(
              context,
              headLineFontWeight500.copyWith(
                  color: AppColors.white,
                  fontSize: getDynamicFontSize(context, 16))),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return Card(
              margin: const EdgeInsets.all(8.0),
              color: AppColors.alto,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['name'],
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.person,
                                size: 20, color: Colors.teal[900]),
                            const SizedBox(width: 8),
                            Text('Age: ${user['age']}'),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              user['dietPreference'] == 'Vegan'
                                  ? Icons.eco
                                  : user['dietPreference'] == 'Pure Vegetarian'
                                      ? Icons.grass
                                      : user['dietPreference'] ==
                                              'Non-Vegetarian'
                                          ? Icons.set_meal
                                          : Icons.egg_alt,
                              size: 20,
                              color: Colors.deepPurple[900],
                            ),
                            const SizedBox(width: 8),
                            Text('Diet: ${user['dietPreference']}'),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.monitor_weight,
                                size: 20, color: Colors.yellow[900]),
                            const SizedBox(width: 8),
                            Text('Weight: ${user['weight']}'),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.flag,
                                size: 20, color: Colors.brown),
                            const SizedBox(width: 8),
                            Text('Goal: ${user['goal']}'),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.health_and_safety,
                                size: 20, color: Colors.blue),
                            const SizedBox(width: 8),
                            Text('Condition: ${user['healthCondition']}'),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.height,
                                size: 20, color: Colors.green),
                            const SizedBox(width: 8),
                            Text('Height: ${user['height']} cm'),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Accept logic here
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Accepted ${user['name']}')),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary),
                          child: Text(
                            'Accept',
                            style: getDynamicTextStyle(
                                context,
                                getDynamicTextStyle(
                                    context,
                                    headLineFontWeight500.copyWith(
                                        color: AppColors.white,
                                        fontSize:
                                            getDynamicFontSize(context, 10)))),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            // Reject logic here
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Rejected ${user['name']}')),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.shadeRed),
                          child: Text('Reject',
                              style: getDynamicTextStyle(
                                  context,
                                  getDynamicTextStyle(
                                      context,
                                      headLineFontWeight500.copyWith(
                                          color: AppColors.white,
                                          fontSize: getDynamicFontSize(
                                              context, 10))))),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
