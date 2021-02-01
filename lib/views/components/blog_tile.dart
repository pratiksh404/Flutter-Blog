import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/views/post.dart';

class BlogTile extends StatelessWidget {
  final String image, title, description, url;
  BlogTile({@required this.image,@required this.title,@required this.description,@required this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(
            builder: (context) => PostView(
              postUrl: url,
            ))
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                  imageUrl: image
              ),
            ),
            SizedBox(height: 8,),
            Text(
                title,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.black87
              ),
            ),
            SizedBox(height: 8,),
            Text(
                description,
            style: TextStyle(
              color: Colors.black54
            ),
            ),
          ],
        ),
      ),
    );
  }
}
