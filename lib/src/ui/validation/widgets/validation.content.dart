import 'package:flutter/material.dart';
import 'package:mktk_app/src/shared/models/boat.model.dart';

class ValidationContent extends StatelessWidget {
  final List<Boat> boats;
  final String boatSelected;
  final void Function(Boat? boat)? onBoatChanged;
  final void Function()? onConfirm;

  const ValidationContent({
    super.key,
    required this.boats,
    required this.boatSelected,
    this.onBoatChanged,
    this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    Color primary = const Color.fromRGBO(84, 163, 212, 1);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "Para continuar informe suas credenciais",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
            decoration: TextDecoration.none,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            vertical: 15.0,
          ),
          child: InputDecorator(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 15.0,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<Boat>(
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
                hint: const Text(
                  "Escolha a embarcação",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
                items: boats.map<DropdownMenuItem<Boat>>((Boat boat) {
                  return DropdownMenuItem(
                    value: boat,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: primary,
                          child: const Icon(
                            Icons.directions_boat_filled_rounded,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(boat.name),
                      ],
                    ),
                  );
                }).toList(),
                isExpanded: true,
                // isDense: true,
                onChanged: (Boat? boat) {
                  onBoatChanged?.call(boat);
                },
                value: boats.firstWhere(
                  (element) => element.abbr == boatSelected,
                ),
              ),
            ),
          ),
        ),
        ElevatedButton(
          style: ButtonStyle(
            elevation: const MaterialStatePropertyAll(0),
            backgroundColor: MaterialStatePropertyAll(primary),
          ),
          onPressed: onConfirm,
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              "Confirmar",
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
        )
      ],
    );
  }
}
