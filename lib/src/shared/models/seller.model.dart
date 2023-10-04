class Seller {
  final int? id;
  final String cpf;
  final String name;
  final String phone;

  Seller({
    required this.cpf,
    required this.name,
    required this.phone,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cpf': cpf,
      'name': name,
      'phone': phone,
    };
  }
}
