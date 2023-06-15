class Connection {
  late String ip;
  late String login;
  late String password;

  Connection([String? ip, String? login, String? password]) {
    this.ip = ip ?? '';
    this.login = login ?? '';
    this.password = password ?? '';
  }

  bool get isEmpty => ip.isEmpty && login.isEmpty;
}
