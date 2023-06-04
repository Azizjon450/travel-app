import 'package:adventure/models/place.dart';
import 'package:adventure/providers/place_provider.dart';
import 'package:adventure/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlaceDetailScreen extends StatefulWidget {
  static const routeName = '/details';
  const PlaceDetailScreen({super.key});

  @override
  State<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments;
    final place = Provider.of<PlaceProvider>(context).getById(id as String);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          place.title,
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              place.image,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            place.location.address,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (ctx) => MapScreen(
                    placeLocation: place.location,
                    isSelicting: false,
                  ),
                ),
              );
            },
            child: const Text('View on map'),
          ),
        ],
      ),
    );
  }
}
