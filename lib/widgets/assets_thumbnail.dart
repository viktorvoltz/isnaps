import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';

class AssetThumbnail extends StatelessWidget {
  final AssetEntity asset;

  const AssetThumbnail({
    Key key,
    @required this.asset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
        future: asset.thumbData,
        builder: (_, snapshot) {
          final bytes = snapshot.data;
          if (bytes == null) return CircularProgressIndicator();
          // return Image.memory(bytes, fit: BoxFit.cover);

          return InkWell(
              onTap: () {},
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.memory(bytes, fit: BoxFit.cover),
                  ),
                  if (asset.type == AssetType.video)
                    Center(
                      child: Container(
                        color: Colors.blue,
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                        ),
                      ),
                    )
                ],
              ));
        });
  }
}