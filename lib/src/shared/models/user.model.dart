class User {
  String name;
  late String createdAt;
  User(this.name) {
    createdAt = DateTime.timestamp().toString();
  }
}
