import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  String img;
  ImageView({this.img});
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'img-$img',
      child: InteractiveViewer(
        child: Image.network(img),
      ),
    );
  }
}
