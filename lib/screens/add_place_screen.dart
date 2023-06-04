import 'dart:io';

import 'package:adventure/models/place.dart';
import 'package:adventure/providers/place_provider.dart';
import 'package:adventure/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/image_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';
  const AddPlaceScreen({super.key});

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _savedImage;
  PlaceLocation? _placeLocation;
  String _title = '';
  final _formKey = GlobalKey<FormState>();

  void _takePickedLocaton(double latitude, double longitude, String address) {
    _placeLocation = PlaceLocation(
      latitude: latitude,
      longitude: longitude,
      address: address,
    );
  }

  void _takeSavedimage(savedImage) {
    _savedImage = savedImage;
  }

  void _submit() {
    //if (_titleController.text.isEmpty && _savedImage == null) {
    if (_title.isNotEmpty && _savedImage != null && _placeLocation != null) {
      return;
    }
    _formKey.currentState!.save();
    Provider.of<PlaceProvider>(context, listen: false).addPlace(
      //_titleController.text, _savedImage!);
      _title,
      _savedImage!,
      _placeLocation!,
    );
    //_formKey.currentState!.save();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Add places'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Add address',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please, enter a place name!';
                              }
                              return null;
                              //return null;
                            },
                            controller: _titleController,
                            onSaved: (value) {
                              _title = value!;
                              //_formKey.currentState!.save();
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ImageInput(_takeSavedimage),
                        const SizedBox(
                          height: 20,
                        ),
                        LocationInput(_takePickedLocaton),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _submit,
            style: ElevatedButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              backgroundColor: Colors.deepPurple,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
            ),
            child: const Text(
              'ADD',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
