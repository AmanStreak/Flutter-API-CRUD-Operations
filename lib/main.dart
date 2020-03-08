import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void main() => runApp(MyApp());

class MyApp extends StatefulWidget{
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp>{

  bool data = false;

  String title, desc;

  final String url = "https://jsonplaceholder.typicode.com/posts/1";



  getData() async{
    debugPrint("hey");
    var response = await http.get(Uri.encodeFull(url));
    debugPrint("oyo");
    if(response.statusCode == 200){
      var responseData = jsonDecode(response.body);
//      print(responseData);
      setState((){
        data = true;
        title = responseData['title'];
        desc = responseData['body'];
      });
    }
  }

  postData() async{
    var response = await http.post(url, body: {
      'userId': '1',
      'id': '101',
      'title': 'heyMan',
      'body': 'yoyo'
    });
    print(response.statusCode);
  }

  updateData() async{
    var response = http.put(url, body: {
      'id': '1',
      'title': 'hey',
      'body': 'Man',
      'userId': '1'
    }).then((data){
      print(data.body);
      print(data.statusCode);
    });
    debugPrint("debug");
//    print(response.runtimeType);
  }

  deleteData() async{
    var response = http.delete(url).then((data){
      print(data.statusCode);
      print(data.body);
    });

  }


  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.fallback(),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: Text("API CRUD"),
          actions: <Widget>[
//            Icon(Icons.add)
          ],
        ),
        body: Container(

          child: Column(

            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              Container(
                height: 200,
                width: 300,
                child: data == false? Center(
                  child: CircularProgressIndicator(),
                ): Column(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(top: 50)
                    ),
                    Text("Title: $title"),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                    ),
                    Text("Desc: $desc"),
                  ],
                ),
              ),
              SizedBox(
                height: 150,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 88),
                child: Row(
                  children: <Widget>[
                    RaisedButton(
                      child: Text("GET", style: TextStyle(color: Colors.white)),
                      color: Colors.pink,
                      onPressed: (){
                        getData();
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                    ),
                    RaisedButton(
                      color: Colors.pink,
                      child: Text("POST", style: TextStyle(color: Colors.white)),
                      onPressed: (){
                        postData();
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 88.0),
                child: Row(
                  children: <Widget>[
                    RaisedButton(
                      color: Colors.pink,
                      onPressed: (){
                        updateData();
                      },
                      child: Text("UPDATE", style: TextStyle(color: Colors.white)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                    ),
                    RaisedButton(
                      color: Colors.pink,
                      onPressed: (){
                        deleteData();
                      },
                      child: Text("DELETE", style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}