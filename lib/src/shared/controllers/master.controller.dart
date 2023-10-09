import 'package:mktk_app/src/shared/controllers/boat.controller.dart';
import 'package:mktk_app/src/shared/controllers/plan.controller.dart';
import 'package:mktk_app/src/shared/controllers/seller.controller.dart';
import 'package:mktk_app/src/shared/controllers/supabase/plansb.controller.dart';
import 'package:mktk_app/src/shared/controllers/supabase/sellersb.controller.dart';
import 'package:mktk_app/src/shared/models/boat.model.dart';
import 'package:mktk_app/src/shared/models/plan.model.dart';
import 'package:mktk_app/src/shared/models/seller.model.dart';

class MasterController {
  static Future<void> save(Boat boat) async {
    Seller seller = await SellerSBController().getSellerById(boat.sellerId!);
    List<Plan> plans = await PlanSBController().getPlansByBoatId(boat.id!);
    await BoatController().save(boat);
    await SellerController().save(seller);
    for (Plan plan in plans) {
      await PlanController().save(plan);
    }
  }

  static Future<void> clear() async {
    await BoatController().clear();
    await SellerController().clear();
    await PlanController().clear();
  }
}
