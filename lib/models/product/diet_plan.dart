class DietPlan {
  final String dietName;
  final List<Map<String, dynamic>> morningSnack;
  final List<Map<String, dynamic>> lunch;
  final List<Map<String, dynamic>> eveningSnack;
  final List<Map<String, dynamic>> dinner;

  DietPlan({
    required this.dietName,
    required this.morningSnack,
    required this.lunch,
    required this.eveningSnack,
    required this.dinner,
  });

  // Convert DietPlan object to JSON
  Map<String, dynamic> toJson() {
    return {
      'diet_name': dietName,
      'morning_snack': morningSnack,
      'lunch': lunch,
      'evening_snack': eveningSnack,
      'dinner': dinner,
    };
  }

  // Convert JSON to DietPlan object
  factory DietPlan.fromJson(Map<String, dynamic> json) {
    return DietPlan(
      dietName: json['diet_name'],
      morningSnack: List<Map<String, dynamic>>.from(json['morning_snack']),
      lunch: List<Map<String, dynamic>>.from(json['lunch']),
      eveningSnack: List<Map<String, dynamic>>.from(json['evening_snack']),
      dinner: List<Map<String, dynamic>>.from(json['dinner']),
    );
  }
}
