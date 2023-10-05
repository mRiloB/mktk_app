import 'package:mktk_app/src/shared/models/plan.model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PlanSBController {
  Future<List<Plan>> getPlansByBoatId(int id) async {
    List<Map<String, dynamic>> plans =
        await Supabase.instance.client.from('boats_plans').select('''
            boat_id,
            plans(name),
            price
          ''');
    List<Plan> boatPlans = plans
        .where((plan) => plan['boat_id'] == id)
        .map(
          (plan) => Plan(
            name: plan['plans']['name'],
            price: plan['price'].toDouble(),
          ),
        )
        .toList();
    return boatPlans;
  }
}
