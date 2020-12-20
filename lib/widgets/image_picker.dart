import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _picker() async {
    final imageFinal =
        await ImagePicker.pickImage(source: ImageSource.gallery, maxWidth: 500);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
