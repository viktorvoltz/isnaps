import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget ({
    Key key,
    @required this.imageFile,
  }): super(key: key);

  final Future<File> imageFile;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return Container(
      color: Colors.black,
      alignment: Alignment.center,
      child: FutureBuilder(
        future: imageFile,
        builder: (_, snapshot){
          final file = snapshot.data;
          if (file == null) return Container();
          return Image.file(file);
        }
        )
    );
  }
}