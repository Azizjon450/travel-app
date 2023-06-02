import 'package:flutter/material.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 5,
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                //color: const Color(0xffdadada),
                color: kDefaultIconLightColor
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: const Text('No location chosen!'),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.location_on),
              onPressed: () {},
              label: const Text('Current location'),
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.map),
              onPressed: () {},
              label: const Text('Select on map'),
            ),
          ],
        ),
      ],
    );
  }
}
