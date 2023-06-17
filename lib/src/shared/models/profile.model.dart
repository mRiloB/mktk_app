class Profile {
  late int id;
  late String mktkId;
  late String name;
  late String limitUptime;
  late double price;

  Profile({
    int? id,
    String? mktkId,
    String? name,
    String? limitUptime,
    double? price,
  }) {
    this.id = id ?? 0;
    this.mktkId = mktkId ?? '';
    this.name = name ?? '';
    this.limitUptime = limitUptime ?? '';
    this.price = price ?? 0.0;
  }

  Map<String, dynamic> toMap([bool noId = false]) {
    Map<String, dynamic> map = {
      'mktk_id': mktkId,
      'name': name,
      'limit_uptime': limitUptime,
      'price': price,
    };
    if (noId) map.remove('id');
    return map;
  }

  @override
  String toString() {
    return 'Profile: { id: $id, mktkId: $mktkId, name: $name, limitUptime: $limitUptime, price: $price }';
  }
}
