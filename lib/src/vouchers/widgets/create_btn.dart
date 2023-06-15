import 'package:flutter/material.dart';
import 'package:mktk_app/src/shared/models/voucher.model.dart';

class CreateBtn extends StatefulWidget {
  const CreateBtn({super.key});

  @override
  State<CreateBtn> createState() => _CreateBtnState();
}

class _CreateBtnState extends State<CreateBtn> {
  void showVoucher(BuildContext context) {
    final voucher = Voucher.generateVoucher();

    Widget cancelBtn = TextButton(
      child: const Text('Cancelar'),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    Widget createBtn = ElevatedButton(
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
          Color(0xFF4758A9),
        ),
      ),
      child: const Text(
        'Confirmar',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      content: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              voucher,
              style: const TextStyle(
                  fontSize: 40.0,
                  color: Color(0xFF4758A9),
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.2,
                  height: 1.4,
                  overflow: TextOverflow.ellipsis,
                  shadows: [
                    Shadow(
                      color: Colors.grey,
                      offset: Offset(1.0, 1.0),
                      blurRadius: 2.0,
                    ),
                  ]),
            ),
          ],
        ),
      ),
      actions: [
        cancelBtn,
        createBtn,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GestureDetector(
        onTap: () {
          showVoucher(context);
        },
        child: const Card(
          color: Color(0xFF4758A9),
          child: SizedBox(
            width: double.infinity,
            height: 150.0,
            child: Center(
              child: Text(
                'Criar Voucher',
                style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.2,
                    height: 1.4,
                    overflow: TextOverflow.ellipsis,
                    shadows: [
                      Shadow(
                        color: Colors.grey,
                        offset: Offset(1.0, 1.0),
                        blurRadius: 2.0,
                      ),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
