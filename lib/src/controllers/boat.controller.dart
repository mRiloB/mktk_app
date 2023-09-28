// import 'package:flutter/material.dart';
import 'package:mktk_app/src/shared/models/boat.model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BoatController {
  Future<List<Boat>> getBoats() async {
    List<Map<String, dynamic>> boats =
        await Supabase.instance.client.from('boats').select();

    return boats
        .map((boat) => Boat(
              abbr: boat['abbr'],
              name: boat['name'],
              id: boat['id'],
              createdAt: boat['created_at'],
              updatedAt: boat['updated_at'],
              partnerId: boat['partner_id'],
              sellerId: boat['seller_id'],
              posId: boat['pos_id'],
              connectionIp: boat['connection_ip'],
              connectionUser: boat['connection_user'],
            ))
        .toList();
  }
}
