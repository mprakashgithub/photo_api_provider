import 'package:flutter/cupertino.dart';
import '../repository/photo_repo.dart';

class PhotoProvider with ChangeNotifier {
  List? photoList;
  bool isLoaded = false;

  Future<void> getPhotoApi() async {
    photoList = await PhotoRepo().getPhotoData();
    print("PhotoList Provider : $photoList");
    setIsLoaded(true);
    notifyListeners();
  }

  bool getIsLoaded() {
    return isLoaded;
  }

  void setIsLoaded(bool value) {
    isLoaded = value;
    notifyListeners();
  }
}
