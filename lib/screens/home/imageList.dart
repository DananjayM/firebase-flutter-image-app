import 'package:flutter/material.dart';
import 'package:flutter_revised_avatar_project/screens/home/imageview.dart';
import 'package:flutter_revised_avatar_project/services/auth.dart';
import 'package:flutter_revised_avatar_project/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ImageCard extends StatefulWidget {
  final String user;
  final String img;
  final String id;
  final int index;
  ImageCard({this.id, this.index, this.user, this.img});
  @override
  _ImageCardState createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  AuthService auth = AuthService();
  @override
  Widget build(BuildContext context) {
    DatabaseService db = DatabaseService(
        uid: auth.getUser().uid, display: auth.getUser().displayName);
    return Dismissible(
      direction: DismissDirection.startToEnd,
      key: Key(widget.img),
      onDismissed: (direction) async {
        await db.removeImage(widget.id, widget.img, auth.getUser().uid);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Image removed")));
      },
      background: Card(
        color: Colors.red,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 20),
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              "Delete",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      child: GestureDetector(
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
      ),
    );
  }
}
