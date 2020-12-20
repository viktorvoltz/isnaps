import 'package:flutter/foundation.dart';

import '../models/picture_model.dart';

class Images with ChangeNotifier {
  List<Picture> _items = [];

  List<Picture> get items {
    return [..._items];
  }

  void newPicture(String newId, double newSize){
    final newPics = Picture(
      id: newId,
      size: newSize
    );
    _items.add(newPics);
    notifyListeners();
  }
}