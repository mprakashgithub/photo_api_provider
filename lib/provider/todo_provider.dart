import 'package:flutter/cupertino.dart';
import '../repository/todo_repo.dart';

class TodoProvider with ChangeNotifier {
  List? todoList;
  List? completedList;
  List? pendingList;
  bool isLoaded = false;

  Future<void> getTodoApi() async {
    todoList = await TodoRepo().getTodoData();
    print("todoList Provider : $todoList");
    for (int i = 0; i < todoList!.length; i++) {
      print(todoList![i]['completed']);
      if (todoList![i]['completed'] == true) {
        completedList!.add(todoList![i]);
        print("true");
      } else {
        print("false");
        pendingList!.add(todoList![i]);
      }
      // if (todoList![i]['completed'] == false) {
      //   pendingList!.add(todoList![i]);
      // } else {
      //   pendingList!.add(todoList![i]);
      // }
      print("25 completedList: $completedList");
      print("26 pendingList: $pendingList");
    }
    setIsLoaded(true);
    notifyListeners();
  }

  getCompletedTasks() {
    print("todoList 18: $todoList");
    for (int i = 0; i < todoList!.length; i++) {
      if (todoList![i]['completed'] == true) {
        completedList!.add(todoList![i]);
      } else {
        pendingList!.add(todoList![i]);
      }
      print("25 completedList: $completedList");
      print("26 pendingList: $pendingList");
    }
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
