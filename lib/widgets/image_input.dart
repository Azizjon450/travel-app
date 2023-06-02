import 'dart:io';

import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart' as systemPath;
import 'package:path/path.dart' as path;

import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final Function takeSavedimage;
  const ImageInput(this.takeSavedimage, {super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _imageFile;

  void _takePicker() async {
    final imagePicker = ImagePicker();
    final photo = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (photo != null) {
      setState(
        () {
          _imageFile = File(photo.path);
        },
      );
      final pathProvider = await systemPath.getApplicationDocumentsDirectory();
      final fileName = path.basename(photo.path);
      final savedImage =
          await _imageFile!.copy('${pathProvider.path}/$fileName');
      widget.takeSavedimage(savedImage);
    }
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
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                //color: const Color(0xffdadada),
                color: kDefaultIconLightColor
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: _imageFile != null
                ? Image.file(
                    _imageFile!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )
                : const Text('Image not found!'),
          ),
        ),
        TextButton.icon(
          icon: const Icon(Icons.camera),
          onPressed: _takePicker,
          label: const Text('Upload image'),
        ),
      ],
    );
  }
}
