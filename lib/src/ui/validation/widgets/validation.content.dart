import 'package:flutter/material.dart';
import 'package:mktk_app/src/shared/models/boat.model.dart';

class ValidationContent extends StatelessWidget {
  final List<Boat> boats;
  final String boatSelected;
  final void Function(Boat? boat)? onBoatChanged;

  const ValidationContent({
    super.key,
    required this.boats,
    required this.boatSelected,
    this.onBoatChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10.0),
          child: const Text(
            "Para continuar informe suas credenciais",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              decoration: TextDecoration.none,
            ),
          ),
        ),
        InputDecorator(
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
                      const CircleAvatar(
                        radius: 16,
                        child: Icon(
                          Icons.directions_boat_filled_rounded,
                          size: 16,
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
      ],
    );
  }
}
