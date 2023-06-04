import 'package:adventure/providers/place_provider.dart';
import 'package:adventure/screens/add_place_screen.dart';
import 'package:adventure/screens/place_details_screen.dart';
import 'package:adventure/screens/places_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PlaceProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Adventure',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          //primarySwatch: Colors.indigo,
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            foregroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.white),
            color: Colors.deepPurple,
          ),
          useMaterial3: true,
        ),
        home: const PlaceListScreen(),
        routes: {
          AddPlaceScreen.routeName:(context) => const AddPlaceScreen(),
          PlaceDetailScreen.routeName: (ctx) => const PlaceDetailScreen(),
        },
      ),
    );
  }
}
