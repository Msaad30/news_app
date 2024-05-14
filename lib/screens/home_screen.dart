import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:news_app/models/fake_user_model.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/models/news_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String fakeApi = "https://jsonplaceholder.typicode.com/todos/1";
  final String newsApi = "https://newsapi.org/v2/everything?q=apple&from=2024-05-06&to=2024-05-06&sortBy=popularity&apiKey=405c3a96634a4010b13e01673404776a";

  @override
  void initState() {
    super.initState();
    newsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NewsPaper App"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: newsData(),
        builder: (context, snapshot) {
          // problem getting null data how to solve ?
          return ListView.builder(
            itemCount: snapshot.data!.articles!.length,
            itemBuilder: (BuildContext context, int index) {
              var news = snapshot.data!.articles![index];
              log(news.toString());
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      news.urlToImage != null ?
                      news.urlToImage.toString() : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZhClrPduBntcW7inSnP7biiX2rgTH0_OXU1_KSAZC4w&s"
                  ),
                ),
                title: Text(news.title.toString()),
                subtitle: Text(news.description.toString()),
              );
            },
          );
        },
      ),
    );
  }

  Future<NewsModel>newsData() async {
    final response = await http.get(Uri.parse(newsApi));
    if(response.statusCode == 200){
      log(response.statusCode.toString());
      Map<String, dynamic> mapData = jsonDecode(response.body);
      log(mapData.toString());
      NewsModel newsModel = NewsModel.fromJson(mapData);
      log(newsModel.toString());
      return newsModel;
    } else {
      log(NewsModel().toString());
      return NewsModel();
    }
  }

  Future<UserModel>fakeGetData()async{
    final responce =  await http.get(Uri.parse(fakeApi));
    if(responce.statusCode == 200){
      Map<String, dynamic> responceData = jsonDecode(responce.body);
      UserModel userModel = UserModel.fromJson(responceData);
      log(userModel.toString());
      return userModel;
    } else {
      return UserModel(userId: 0, id: 0, title: '', completed: false);
    }
  }

}
