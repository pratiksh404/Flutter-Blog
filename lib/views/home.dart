import 'package:flutter/material.dart';
import 'package:news/helper/blogs.dart';
import 'package:news/helper/data.dart';
import 'package:news/models/blog_model.dart';
import 'package:news/views/components/blog_tile.dart';
import 'package:news/views/components/category_tile.dart';

// Models
import 'package:news/models/category_model.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = new List<CategoryModel>();
  List<BlogModel> blogs = new List<BlogModel>();
  bool loading = true;
  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getBlogs();
  }

  getBlogs() async {
    Blogs blogsData = Blogs();
    await blogsData.getBlogs();
    blogs = blogsData.blogs;
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
      ) : SingleChildScrollView(
        child: Container(
          child: Column(
        children: <Widget>[
          // Categories
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            height: 70,
            child: ListView.builder(
              itemCount: categories.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index)
                {
                  return CategoryTile(
                    imageUrl: categories[index].categoryImage,
                    categoryName: categories[index].categoryName,
                  );
                }
            ),
          ),
          // Blogs
          Container(
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
        ],
          ),
        ),
      ),
    );
  }
}



