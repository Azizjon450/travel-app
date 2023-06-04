import 'package:adventure/helpers/location_helpers.dart';
import 'package:adventure/models/place.dart';
import 'package:adventure/screens/map_screen.dart';
import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationInput extends StatefulWidget {
  final Function takePickedLocaton;
  const LocationInput(this.takePickedLocaton, {super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  // Future<void> _getCurrentLocation() async {
  //   await Geolocator.checkPermission();
  //   await Geolocator.requestPermission();

  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  //   final _staticImage = LocationHelper.getLocationImage(
  //       latitude: position.latitude, longtitude: position.longitude);
  //   print(_staticImage);
  //   setState(() {
  //     _previewImageUrl = _staticImage;
  //   });
  // }

  Future<void> _getCurrentLocation() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _getLocationImage(LatLng(position.latitude, position.longitude));
  }

  void _getLocationImage(LatLng location) async {
    setState(() {
      _previewImageUrl = LocationHelper.getLocationImage(
          latitude: location.latitude, longtitude: location.longitude);
    });
    final String formattedAddress =
        await LocationHelper.getFormattedAddress(location);

    widget.takePickedLocaton(
      location.latitude,
      location.longitude,
      formattedAddress,
    );
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
            child: _getCurrentLocation == null
                ? const Text('No location chosen!')
                : Image.network(_getCurrentLocation.toString()),
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
              onPressed: () async {
                final selectedLocation =
                    await Navigator.of(context).push<LatLng>(
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (ctx) => MapScreen(
                      placeLocation: PlaceLocation(
                          latitude: 37.4219991,
                          longitude: -122.0840011,
                          address: 'Tashkent'),
                      isSelicting: true,
                    ),
                  ),
                );
                if (selectedLocation == null) {
                  return;
                }
                _getLocationImage(selectedLocation);
              },
              label: const Text('Select on map'),
            ),
          ],
        ),
      ],
    );
  }
}
