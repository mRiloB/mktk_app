class Boat {
  String abbr;
  String name;
  int? id;
  String? createdAt;
  String? updatedAt;
  int? partnerId;
  int? sellerId;
  int? posId;
  String? connectionIp;
  String? connectionUser;

  Boat({
    required this.abbr,
    required this.name,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.partnerId,
    this.sellerId,
    this.posId,
    this.connectionIp,
    this.connectionUser,
  });
}
