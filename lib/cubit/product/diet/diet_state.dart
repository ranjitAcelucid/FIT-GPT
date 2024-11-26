import 'package:sales/models/product/diet_plan.dart';

abstract class DietPlanState {}

class DietPlanInitial extends DietPlanState {}

class DietPlanLoaded extends DietPlanState {
  final List<DietPlan> dietPlans;

  DietPlanLoaded(this.dietPlans);
}
