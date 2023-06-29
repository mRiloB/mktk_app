import 'dart:math';

class Voucher {
  late int id;
  late String name;
  late String server;
  late String profile;
  late String limitUptime;
  late double price;
  late String createdAt;
  late String updatedAt;
  late String payment;

  Voucher(
      {int? id,
      String? name,
      String? server,
      String? profile,
      String? limitUptime,
      double? price,
      String? createdAt,
      String? updatedAt,
      String? payment}) {
    this.id = id ?? 0;
    this.name = name ?? '';
    this.server = server ?? '';
    this.profile = profile ?? '';
    this.limitUptime = limitUptime ?? '';
    this.price = price ?? 0.0;
    this.createdAt = createdAt ?? '';
    this.updatedAt = updatedAt ?? '';
    this.payment = payment ?? '';
  }

  Map<String, dynamic> toMap([bool noId = false]) {
    Map<String, dynamic> map = {
      "id": id,
      "name": name,
      "server": server,
      "profile": profile,
      "limit_uptime": limitUptime,
      "price": price.toString(),
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "payment": payment
    };
    if (noId) map.remove('id');
    return map;
  }

  @override
  String toString() {
    return 'Voucher { name: $name, server: $server, profile: $profile, limit-uptime: $limitUptime, price: $price, createdAt: $createdAt, updatedAt: $updatedAt, payment: $payment }';
  }

  static String generateVoucher() {
    const length = 4;
    // const letterLowerCase = "abcdefghijklmnopqrstuvwxyz";
    const letterUpperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    const number = '0123456789';
    // const special = '@#*?!=+';

    String chars = "";
    chars += letterUpperCase;
    chars += number;

    return List.generate(length, (index) {
      final indexRandom = Random.secure().nextInt(chars.length);
      return chars[indexRandom];
    }).join('');
  }
}
