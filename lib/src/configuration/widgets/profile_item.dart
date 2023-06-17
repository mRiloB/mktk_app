import 'package:flutter/material.dart';
import 'package:mktk_app/src/shared/models/profile.model.dart';

class ProfileItem extends StatelessWidget {
  final Profile profile;
  final void Function() onPressed;
  final void Function() onLongPress;

  const ProfileItem(
    this.profile,
    this.onPressed,
    this.onLongPress, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(profile.name),
        subtitle: Text('R\$ ${profile.price} - [${profile.limitUptime}]'),
        trailing: IconButton.filled(
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.red),
          ),
          color: Colors.white,
          onPressed: onPressed,
          icon: const Icon(Icons.delete),
        ),
        onLongPress: onLongPress,
      ),
    );
  }
}
