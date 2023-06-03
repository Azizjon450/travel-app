import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;
  
  Future<void> _getCurrentLocation() async {
      await Geolocator.checkPermission();
      await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print('ss');
    print(position);
  }

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
                  color: kDefaultIconLightColor),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: _getCurrentLocation() == null ? const Text('No location chosen!') : Image.network(_getCurrentLocation.toString()),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.location_on),
              onPressed: _getCurrentLocation,
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
