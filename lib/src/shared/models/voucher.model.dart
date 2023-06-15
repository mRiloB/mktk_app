class Voucher {
  String name;
  String server;
  String profile;
  String limitUptime;

  Voucher(this.name, this.server, this.profile, this.limitUptime);

  Map<String, String> toJson() => {
        "name": name,
        "server": server,
        "profile": profile,
        "limit-uptime": limitUptime
      };
}
