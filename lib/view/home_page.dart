import 'package:api_repo_provider/provider/home_provider.dart';
import 'package:api_repo_provider/view/photo_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? _width, _height;
  late HomeProvider homeProvider;
  var countryList;

  @override
  void initState() {
    super.initState();
    homeProvider = Provider.of<HomeProvider>(context, listen: false);
    countryList = homeProvider.getCountryApi();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
        floatingActionButton: MaterialButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => PhotoPage())));
          },
          height: 40,
          minWidth: 40,
          color: Colors.blueAccent,
          child: Icon(Icons.navigate_next_sharp),
        ),
        body: Consumer<HomeProvider>(builder: (context, provider, child) {
          return SafeArea(
            child: Container(
              height: _height,
              padding: const EdgeInsets.only(top: 20),
              child: !provider.isLoaded
                  ? SizedBox(
                      height: 100.0,
                      child: Shimmer.fromColors(
                          period: Duration(seconds: 2),
                          baseColor: Colors.grey,
                          highlightColor: Colors.white,
                          child: ListView.separated(
                            itemCount: 30,
                            itemBuilder: (context, index) => Container(
                              color: Colors.grey,
                              height: 20,
                              width: _width,
                            ),
                            separatorBuilder: (context, index) => ListTile(
                              title: Text(
                                " ",
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          )),
                    )
                  : ListView.builder(
                      itemCount: provider.model!.data!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            provider.model!.data![index].country!,
                            style: const TextStyle(color: Colors.black),
                          ),
                        );
                      }),
            ),
          );
        }));
  }
}
