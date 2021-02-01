import 'dart:convert';

import 'package:news/models/blog_model.dart';
import 'package:http/http.dart' as http;
class CategoryBlogs{
  List<BlogModel> blogs = [];
  Future<void> getCategoryBlogs(String category) async{
    String url = "http://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=3ef02f920eaa456a82f365c5e9e9499c";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok")
    {
      jsonData['articles'].forEach((element) {
        if(element["urlToImage"] != null && element["description"] != null)
        {
          BlogModel blogModel = new BlogModel(
              author: element['author'],
              title: element['title'],
              description: element['description'],
              url: element['url'],
              image: element['urlToImage'],
              content: element['content']
          );

          blogs.add(blogModel);
        }
      });
    }
  }
}