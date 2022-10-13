import 'dart:convert';

import 'package:http/http.dart' as http;
import '../model/todo_model.dart';

class TodoRepo {
  List todoList = [];
  Future<List?> getTodoData() async {
    try {
      var request = http.Request(
          'GET', Uri.parse('https://jsonplaceholder.typicode.com/todos'));
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        print("TodoList: $todoList");
        var data = await response.stream.bytesToString();
        print("data : $data");
        var map = json.decode(data);
        print("map : $map");
        map.forEach((element) {
          print("element: $element");
          todoList.add(element);
        });
        // var model = TodoModel.fromJson(map);
        // print(model);
        // return model;
        return todoList;
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      throw (e);
    }
  }
}
