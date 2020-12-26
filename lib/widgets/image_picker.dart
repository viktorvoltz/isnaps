import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageSelector extends StatefulWidget {
  static const routeName = '/image-selector';
  @override
  _ImageSelectorState createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  File _image;

  Future<void> _imageFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 100);
    setState(() {
      _image = image;
    });
  }

  Future<void> _imageFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 100);
    setState(() {
      _image = image;
    });
  }

  void _selectMedia(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext ctx) {
          return SafeArea(
              child: Container(
            child: new Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text('photo Library'),
                  onTap: () => _imageFromGallery(),
                ),
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text('camera'),
                  onTap: () => _imageFromCamera(),
                ),
              ],
            ),
          ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: FlatButton(
      child: Text('button'),
      onPressed: () => _selectMedia(context),
    )));
  }
}
