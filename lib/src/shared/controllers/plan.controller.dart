import 'package:mktk_app/src/shared/models/plan.model.dart';
import 'package:mktk_app/src/shared/storage/plan.storage.dart';

class PlanController {
  Future<List<Plan>> getPlans() async {
    List<Map<String, dynamic>> plans = await PlanStorage.select();
    return plans
        .map(
          (plan) => Plan(
            name: plan['name'],
            price: plan['price'],
            limitUptime: plan['limit_uptime'],
          ),
        )
        .toList();
  }

  Future<void> save(Plan plan) async {
    await PlanStorage.insert(plan);
  }

  Future<void> clear() async {
    await PlanStorage.deleteAll();
  }
}
