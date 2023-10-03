class Resource {
  final String architecturename;
  final String badblocks;
  final String boardname;
  final String buildtime;
  final String cpu;
  final String cpucount;
  final String cpufrequency;
  final String cpuload;
  final String factorysoftware;
  final String freehddspace;
  final String freememory;
  final String platform;
  final String totalhddspace;
  final String totalmemory;
  final String uptime;
  final String version;
  final String writesectsincereboot;
  final String writesecttotal;

  Resource({
    required this.architecturename,
    required this.badblocks,
    required this.boardname,
    required this.buildtime,
    required this.cpu,
    required this.cpucount,
    required this.cpufrequency,
    required this.cpuload,
    required this.factorysoftware,
    required this.freehddspace,
    required this.freememory,
    required this.platform,
    required this.totalhddspace,
    required this.totalmemory,
    required this.uptime,
    required this.version,
    required this.writesectsincereboot,
    required this.writesecttotal,
  });
}
