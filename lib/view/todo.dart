import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../provider/todo_provider.dart';

class ToDo extends StatefulWidget {
  const ToDo({Key? key}) : super(key: key);

  @override
  State<ToDo> createState() => ToDoState();
}

class ToDoState extends State<ToDo> {
  double? _width, _height;
  late TodoProvider todoProvider;
  var todoList;

  @override
  void initState() {
    super.initState();
    todoProvider = Provider.of<TodoProvider>(context, listen: false);
    todoList = todoProvider.getTodoApi();

    Future.delayed(
      Duration(seconds: 4),
      () {
        // todoProvider.getCompletedTasks();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text("TODO API"),
        ),
        body: Consumer<TodoProvider>(builder: (context, provider, child) {
          return SafeArea(
            child: Container(
              height: _height,
              padding: const EdgeInsets.only(top: 20),
              child: !provider.isLoaded
                  ? SizedBox(
                      height: 100.0,
                      child: Shimmer.fromColors(
                          baseColor: Colors.grey,
                          highlightColor: Colors.white,
                          child: ListView.separated(
                            itemCount: 30,
                            itemBuilder: (context, index) => Container(
                              color: Colors.grey,
                              height: 20,
                              width: _width,
                            ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 10),
                          )),
                    )
                  : ListView.builder(
                      itemCount: provider.completedList!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Text(
                              provider.completedList![index]['id'].toString()),
                          title: Text(
                            provider.completedList![index]['title'].toString(),
                            style: const TextStyle(color: Colors.black),
                          ),
                          trailing: Text(provider.completedList![index]
                                  ['completed']
                              .toString()),
                        );
                      }),
            ),
          );
        }));
  }
}
