import 'dart:convert';

import 'package:http/http.dart' as http;
import '../model/photo_model.dart';

class PhotoRepo {
  List photoList = [];
  Future<List?> getPhotoData() async {
    try {
      var request = http.Request(
          'GET', Uri.parse('https://jsonplaceholder.typicode.com/photos'));
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        print("photoList: $photoList");
        var data = await response.stream.bytesToString();
        print("data : $data");
        var map = json.decode(data);
        print("map : $map");
        map.forEach((element) {
          print("element: $element");
          photoList.add(element);
        });
        // var model = PhotoModel.fromJson(map);
        // print(model);
        // return model;
        return photoList;
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      throw (e);
    }
  }
}
