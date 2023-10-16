import 'package:flutter/material.dart';
import 'package:mktk_app/src/shared/models/voucher.model.dart';
import 'package:mktk_app/src/ui/home/widgets/home.container.dart';

class HistoryList extends StatelessWidget {
  final List<Voucher> vouchers;
  const HistoryList({super.key, required this.vouchers});

  @override
  Widget build(BuildContext context) {
    Color primary = const Color.fromRGBO(84, 163, 212, 1);
    return HomeContainer(
      title: 'Vouchers vendidos: ${vouchers.length}',
      children: [
        ListView(
          shrinkWrap: true,
          children: [
            ...vouchers.map(
              (voucher) => Card(
                color: primary,
                child: ListTile(
                  leading: const Icon(
                    Icons.wifi,
                    color: Colors.white,
                  ),
                  title: Text(
                    voucher.name,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    '${voucher.profile} | ${voucher.payment}',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  minLeadingWidth: 0,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
