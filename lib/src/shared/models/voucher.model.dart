class Voucher {
  final int? id;
  final String name;
  final String server;
  final String profile;
  final String limitUptime;
  final double price;
  final String payment;
  String? createdAt;
  final String? updatedAt;

  Voucher({
    this.id,
    required this.name,
    required this.server,
    required this.profile,
    required this.limitUptime,
    required this.payment,
    required this.price,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "server": server,
      "profile": profile,
      "limit_uptime": limitUptime,
      "price": price.toString(),
      "created_at": createdAt,
      "updated_at": updatedAt,
      "payment": payment
    };
  }

  @override
  String toString() {
    return '''
Voucher {
  name: $name,
  server: $server,
  profile: $profile,
  limit-uptime: $limitUptime,
  price: $price,
  payment: $payment,
  createdAt: $createdAt,
  updatedAt: $updatedAt
}
''';
  }
}
