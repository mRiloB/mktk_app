class Plan {
  final int? id;
  final String name;
  final double price;
  final String limitUptime;

  Plan({
    required this.name,
    required this.price,
    required this.limitUptime,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'limit_uptime': limitUptime,
    };
  }
}
