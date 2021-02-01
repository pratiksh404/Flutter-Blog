import 'package:flutter/material.dart';
import 'package:news/helper/blogs.dart';
import 'package:news/helper/category.dart';
import 'package:news/models/blog_model.dart';
import 'package:news/views/components/blog_tile.dart';

class CategoryPosts extends StatefulWidget {

  final String category;
  CategoryPosts({this.category});

  @override
  _CategoryPostsState createState() => _CategoryPostsState();
}

class _CategoryPostsState extends State<CategoryPosts> {
  List<BlogModel> blogs = new List<BlogModel>();
  bool loading = true;
  @override
  void initState() {
    super.initState();
    getCategoryBlogs();
  }

  getCategoryBlogs() async {
    CategoryBlogs categoryblogsData = CategoryBlogs();
    await categoryblogsData.getCategoryBlogs(widget.category);
    blogs = categoryblogsData.blogs;
    setState(() {
      loading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Flutter"),
            Text(
              "News/Blog",
              style: TextStyle(
                  color: Colors.blue
              ),
            ),
          ],
        ),
        elevation: 0.0,
      ),
      body: loading
        ? Container(
        child: Center(child: CircularProgressIndicator()),
      ) :   SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 16),
          child: ListView.builder(
              physics: ClampingScrollPhysics(),
              itemCount: blogs.length,
              shrinkWrap: true,
              itemBuilder: (context,index){
                return BlogTile(
                  image: blogs[index].image,
                  title: blogs[index].title,
                  description: blogs[index].description,
                  url: blogs[index].url,
                );
              }
          ),
        ),
      ),
    );
  }
}
