import 'package:bloc/bloc.dart';
import 'package:sales/cubit/product/diet/diet_state.dart';
import 'package:sales/models/product/diet_plan.dart';

class DietPlanCubit extends Cubit<DietPlanState> {
  DietPlanCubit() : super(DietPlanInitial());

  final List<DietPlan> _dietPlans = [];

  void addDietPlan(Map<String, dynamic> dietData) {
    final newDietPlan = DietPlan.fromJson(dietData);
    _dietPlans.add(newDietPlan);

    // Emit the updated list to refresh the UI
    emit(DietPlanLoaded(List.from(_dietPlans)));
    print(_dietPlans.length);
  }

  // You can also add a fetchDietPlans method to fetch the data
  void fetchDietPlans() {
    emit(DietPlanLoaded(List.from(_dietPlans)));
  }
}
