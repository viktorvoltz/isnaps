import 'package:flutter/material.dart';
import 'screens/homescreen.dart';
import 'package:flutter/services.dart';
import 'package:photo_manager/photo_manager.dart';
import 'widgets/image_picker.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ISNAPS',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        ImageSelector.routeName: (ctx) => ImageSelector(),
      },
      home: PermScreen(),
    );
  }
}

class PermScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.purple,
      statusBarBrightness: Brightness.dark,
    ));
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Colors.white,
        elevation: 0,
        /* actions: [
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
        ],*/
      ),
      body: Center(
        child: RaisedButton(
           onPressed: () async {
            final permitted = await PhotoManager.requestPermission();
            if (!permitted) return;
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => HomeScreen()));
          },
          child: Text('Open Gallery'),
        ),
      ),
    );
  }
}

