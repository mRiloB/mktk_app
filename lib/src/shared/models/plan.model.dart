class Plan {
  final int? id;
  final String name;
  final double price;

  Plan({
    required this.name,
    required this.price,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
    };
  }
}
