class Info {
  late String boat;
  late String seller;

  Info([String? boat, String? seller]) {
    this.boat = boat ?? '';
    this.seller = seller ?? '';
  }

  Map<String, String> toMap() {
    return {
      'boat': boat,
      'seller': seller,
    };
  }

  @override
  String toString() {
    return 'Info { boat: $boat, seller: $seller }';
  }

  bool get isEmpty => boat.isEmpty && seller.isEmpty;
}
