import 'package:flutter/material.dart';
import 'package:flutter_revised_avatar_project/screens/home/imageview.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ImageCard extends StatefulWidget {
  final String user;
  final String img;
  ImageCard({this.user, this.img});
  @override
  _ImageCardState createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ImageView(img: widget.img)));
      },
      child: Card(
        child: Row(
          children: [
            ClipRRect(
              child: Hero(
                tag: 'img-${widget.img}',
                child: Image.network(
                  widget.img,
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.2,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              width: 30,
            ),
            Text("${widget.user}"),
          ],
        ),
      ),
    );
  }
}
