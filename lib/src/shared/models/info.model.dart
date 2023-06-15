class Info {
  late String boatName;
  late String seller;

  Info([String? boatName, String? seller]) {
    this.boatName = boatName ?? '';
    this.seller = seller ?? '';
  }

  bool get isEmpty => boatName.isEmpty && seller.isEmpty;
}
