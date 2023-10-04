import 'package:mktk_app/src/shared/models/plan.model.dart';
import 'package:mktk_app/src/shared/storage/plan.storage.dart';

class PlanController {
  Future<Plan?> getBoat() async {
    List<Map<String, dynamic>> plans = await PlanStorage.select();
    if (plans.isEmpty) return null;
    return Plan(
      name: plans.first['name'],
      price: plans.first['price'],
    );
  }

  Future<void> save(Plan plan) async {
    await PlanStorage.insert(plan);
  }

  Future<void> clear() async {
    await PlanStorage.deleteAll();
  }
}
