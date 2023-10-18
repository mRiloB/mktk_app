import 'package:flutter/material.dart';
import 'package:mktk_app/src/shared/services/api.service.dart';
import 'package:mktk_app/src/shared/widgets/error_dialog.dart';
import 'package:mktk_app/src/shared/widgets/list_card.dart';
import 'package:mktk_app/src/shared/widgets/moby_container.dart';
import 'package:mktk_app/src/ui/home/widgets/home.container.dart';

class Active {
  final String? id;
  final String? address;
  final String? bytesin;
  final String? bytesout;
  final String? idletime;
  final String? keepalivetimeout;
  final String? loginby;
  final String? macaddress;
  final String? packetsin;
  final String? packetsout;
  final String? radius;
  final String? server;
  final String? uptime;
  final String? user;
  final String? comment;
  final String? sessiontimeleft;

  Active({
    this.id,
    this.address,
    this.bytesin,
    this.bytesout,
    this.idletime,
    this.keepalivetimeout,
    this.loginby,
    this.macaddress,
    this.packetsin,
    this.packetsout,
    this.radius,
    this.server,
    this.uptime,
    this.user,
    this.comment,
    this.sessiontimeleft,
  });
}

class ActivePage extends StatefulWidget {
  const ActivePage({super.key});

  @override
  State<ActivePage> createState() => _ActivePageState();
}

class _ActivePageState extends State<ActivePage> {
  List<Active> actives = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadActives();
  }

  void loadActives() async {
    setState(() {
      isLoading = true;
    });
    try {
      List<dynamic> apiActives = await MkTkAPI.cmdPrint('/ip/hotspot/active');
      setState(() {
        for (Map<String, dynamic> active in apiActives) {
          actives.add(
            Active(
              id: active['.id'],
              address: active['address'],
              bytesin: active['bytes-in'],
              bytesout: active['bytes-out'],
              comment: active['comment'],
              idletime: active['idle-time'],
              keepalivetimeout: active['keepalive-timeout'],
              loginby: active['login-by'],
              macaddress: active['mac-address'],
              packetsin: active['packets-in'],
              packetsout: active['packets-out'],
              radius: active['radius'],
              server: active['server'],
              sessiontimeleft: active['session-time-left'],
              uptime: active['uptime'],
              user: active['user'],
            ),
          );
        }
      });
    } catch (e) {
      debugPrint('=== active error: ${e.toString()}');
      if (!mounted) return;
      await showDialog(
        context: context,
        builder: (BuildContext context) => ErrorDialog(
          message: e.toString(),
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MobyContainer(
      isLoading: isLoading,
      children: [
        HomeContainer(title: 'Usuários ativos: ${actives.length}'),
        ...actives.map(
          (active) => ListCard(
            icon: Icons.wifi,
            title: active.user!,
            subtitle: '${active.address} | ${active.macaddress}',
          ),
        ),
      ],
    );
  }
}
