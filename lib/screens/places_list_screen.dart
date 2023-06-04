import 'package:adventure/providers/place_provider.dart';
import 'package:adventure/screens/add_place_screen.dart';
import 'package:adventure/screens/place_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlaceListScreen extends StatelessWidget {
  const PlaceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adventure'),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, AddPlaceScreen.routeName),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
          future:
              Provider.of<PlaceProvider>(context, listen: false).getPlaces(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Consumer<PlaceProvider>(
              builder: (context, placeProvider, child) {
                if (placeProvider.list.isNotEmpty) {
                  return ListView.builder(
                    itemCount: placeProvider.list.length,
                    itemBuilder: (ctx, index) => ListTile(
                      leading: CircleAvatar(
                        backgroundImage: FileImage(
                          placeProvider.list[index].image,
                        ),
                      ),
                      title: Text(
                        placeProvider.list[index].title,
                      ),
                      subtitle:
                          Text(placeProvider.list[index].location.address),
                      onTap: () {
                        //detail_screen
                        Navigator.of(context).pushNamed(
                          PlaceDetailScreen.routeName,
                          arguments: placeProvider.list[index].id,
                        );
                      },
                    ),
                  );
                } else {
                  return child!;
                }
              },
              child: const Center(
                child: Text(
                  'No travel place names found, please enter a place name!',
                ),
              ),
            );
          }),
    );
  }
}
