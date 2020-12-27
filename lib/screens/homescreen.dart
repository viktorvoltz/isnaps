import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../widgets/assets_thumbnail.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'dart:io';
import 'package:image_picker/image_picker.dart';


class HomeScreen extends StatefulWidget {
  final routeName = '/homescreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Random rnd = new Random();
  int random = new Random().nextInt(2);
  List<AssetEntity> assets = [];

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

  void _fetchAssets() async {
    final albums = await PhotoManager.getAssetPathList(onlyAll: true);
    final recentAlbum = albums.first;

    final recentAssets = await recentAlbum.getAssetListRange(
      start: 0,
      end: 10000,
    );

    setState(() {
      assets = recentAssets;
    });
  }

  @override
  void initState() {
    _fetchAssets();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.purple,
      statusBarBrightness: Brightness.dark,
    ));
    super.didChangeDependencies();
  }

  


  @override
  Widget build(BuildContext context) {
    /*SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.purple,
      statusBarBrightness: Brightness.dark,
    ));*/
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.greenAccent,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.camera_alt),
              onPressed: (){
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
              },
              color: Colors.purple,
            ),
            SizedBox(width: 100),
            Container(
              child: FlatButton(
                onPressed: () {},
                child: Text('Group'),
                color: Colors.white,
              ),
            )
          ],
        ),
        body: StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          itemCount: assets.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                width: size.width,
                height: 120,
                child: AssetThumbnail(asset: assets[index]));
          },
          staggeredTileBuilder: (index) => StaggeredTile.count(
              assets[index].type == AssetType.video ? 2 : 1,
              assets[index].type == AssetType.video ? 2 : 1),
          mainAxisSpacing: 3.5,
          crossAxisSpacing: 3.5,
        ));
  }
}
