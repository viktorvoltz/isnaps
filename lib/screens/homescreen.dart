import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../widgets/assets_thumbnail.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {

  final routeName = '/homescreen';


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Random rnd = new Random();
  int random = new Random().nextInt(2);
  List<AssetEntity> assets = [];

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
  Widget build(BuildContext context) {
    final size =MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.lock),
            onPressed: () {},
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
        itemBuilder: (BuildContext context, int index){
          return Container(
            width: size.width,
            height: 120,
            child: AssetThumbnail(asset: assets[index])
          );
        }, 
        staggeredTileBuilder: (index) => StaggeredTile.count(index.isOdd? 1 : random + 1, index.isEven ? 1 : random + 1),
        mainAxisSpacing: 2.0,
        crossAxisSpacing: 2.0,
        )
      
    );
  }
}
