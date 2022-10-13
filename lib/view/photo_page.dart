import 'package:api_repo_provider/provider/home_provider.dart';
import 'package:api_repo_provider/view/todo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../provider/photo_provider.dart';
import 'steper.dart';

class PhotoPage extends StatefulWidget {
  const PhotoPage({Key? key}) : super(key: key);

  @override
  State<PhotoPage> createState() => PhotoPageState();
}

class PhotoPageState extends State<PhotoPage> {
  double? _width, _height;
  late PhotoProvider photoProvider;
  var photoList;

  @override
  void initState() {
    super.initState();
    photoProvider = Provider.of<PhotoProvider>(context, listen: false);
    photoList = photoProvider.getPhotoApi();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text("Photo API"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => StepperPage()));
                },
                icon: Icon(Icons.start))
          ],
        ),
        body: Consumer<PhotoProvider>(builder: (context, provider, child) {
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
                      itemCount: provider.photoList!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: SizedBox(
                            height: 30,
                            width: 30,
                            child: Image.network(
                              provider.photoList![index]['url'],
                              fit: BoxFit.cover,
                            ),
                          ),
                          trailing:
                              Text(provider.photoList![index]['id'].toString()),
                          title: Text(
                            provider.photoList![index]['title'].toString(),
                            style: const TextStyle(color: Colors.black),
                          ),
                        );
                      }),
            ),
          );
        }));
  }
}
