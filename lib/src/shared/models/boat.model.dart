class Boat {
  int? id;
  String abbr;
  String name;
  int? partnerId;
  int? sellerId;
  int? posId;
  String? connectionIp;
  String? connectionUser;

  Boat({
    this.id,
    required this.abbr,
    required this.name,
    this.partnerId,
    this.sellerId,
    this.posId,
    this.connectionIp,
    this.connectionUser,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'abbr': abbr,
      'name': name,
      'partner_id': partnerId,
      'seller_id': sellerId,
      'pos_id': posId,
      'connection_ip': connectionIp,
      'connection_user': connectionUser,
    };
  }

  @override
  String toString() {
    return '''
    Boat
    {
      id: $id,
      abbr: $abbr,
      name: $name,
      partner_id: $partnerId,
      seller_id: $sellerId,
      pos_id: $posId,
      connection_ip: $connectionIp,
      connection_user: $connectionUser,
    }
    ''';
  }
}
