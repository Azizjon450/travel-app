import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:adventure/database/places_database.dart';
import 'package:flutter/material.dart';
import 'package:adventure/models/place.dart';

class PlaceProvider with ChangeNotifier {
  List<Place> _list = [];

  List<Place> get list {
    return [..._list];
  }

  Place findById(String id) {
    return _list.firstWhere((place) => place.id == id);
  }

  Place getById(String id) {
    return _list.firstWhere((place) => place.id == id);
  }

  void addPlace(String title, File image, PlaceLocation placeLocation) async {
    final newPlace = Place(
      id: UniqueKey().toString(),
      title: title,
      location: placeLocation,
      image: image,
    );
    _list.add(newPlace);
    notifyListeners();

    PlacesDB.insert(
      'user_places',
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
        'location_lat': newPlace.location.latitude,
        'location_lng': newPlace.location.longitude,
        'address': newPlace.location.address,
      },
    );
  }

  Future<void> getPlaces() async {
    final placesList = await PlacesDB.getData('user_places');
    _list = placesList
        .map(
          (place) => Place(
            id: place['id'],
            title: place['title'],
            image: File(place['image']),
            location: PlaceLocation(
              latitude: place['location_lat'],
              longitude: place['location_lng'],
              address: place['address'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }
}
