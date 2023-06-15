import 'dart:math';

class Voucher {
  late String name;
  late String server;
  late String profile;
  late String limitUptime;

  Voucher([
    String? name,
    String? server,
    String? profile,
    String? limitUptime,
  ]) {
    this.name = name ?? '';
    this.server = server ?? '';
    this.profile = profile ?? '';
    this.limitUptime = limitUptime ?? '';
  }

  Map<String, String> toMap() => {
        "name": name,
        "server": server,
        "profile": profile,
        "limit-uptime": limitUptime
      };

  static String generateVoucher() {
    const length = 4;
    const letterLowerCase = "abcdefghijklmnopqrstuvwxyz";
    // const letterUpperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    const number = '0123456789';
    // const special = '@#*?!=+';

    String chars = "";
    chars += letterLowerCase;
    chars += number;

    return List.generate(length, (index) {
      final indexRandom = Random.secure().nextInt(chars.length);
      return chars[indexRandom];
    }).join('');
  }
}
