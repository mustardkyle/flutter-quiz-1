import 'dart:convert';
 
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget{
  createState(){
    return AppState();
  }
}

class ImageModel {
  int id;
  String url;
  String title;

  ImageModel(int id, String url, String title){
    this.id=id;
    this.url=url;
    this.title=title;
  }

  ImageModel.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    url = parsedJson['url'];
    title = parsedJson['title'];
  }
}

class AppState extends State<MyApp> {
  int counter = 0;
  List<ImageModel> list = []; 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("imo mama picture"),
        ),
        body: Center(
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return Padding(
                  	padding: EdgeInsets.all(10.0),
                  	child: Container(
                    		padding: EdgeInsets.all(15.0),
                    		decoration: BoxDecoration(
                      		border: Border.all(),
                    ),
                    child: Column(
                      children: <Widget>[
                        Image.network(list[index].url),
                        Text(list[index].title),
                      ],
                    )
                  ),
                );
              } 
            )
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            fetchImage();
          },
          child: Icon(Icons.add)
        )
      )
    );
  }

  void fetchImage() async{
    counter++;
    var response= await http.get('https://jsonplaceholder.typicode.com/photos/$counter');
    setState((){
      list.add(ImageModel.fromJson(jsonDecode(response.body)));
    });
  }
}
