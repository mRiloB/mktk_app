class Connection {
  late String ip;
  late String login;
  late String password;

  Connection([String? ip, String? login, String? password]) {
    this.ip = ip ?? '';
    this.login = login ?? '';
    this.password = password ?? '';
  }

  Map<String, String> toMap() {
    return {
      'ip': ip,
      'login': login,
      'password': password,
    };
  }

  @override
  String toString() {
    return 'Info {ip: $ip, login: $login, password: $password}';
  }

  bool get isEmpty => ip.isEmpty && login.isEmpty;
}
