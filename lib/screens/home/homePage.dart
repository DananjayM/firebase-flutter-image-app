import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_revised_avatar_project/screens/home/imageList.dart';
import 'package:flutter_revised_avatar_project/services/auth.dart';
import 'package:flutter_revised_avatar_project/services/database.dart';
import 'package:flutter_revised_avatar_project/services/database.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthService auth = AuthService();
  File _image, _image1;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    DatabaseService db = DatabaseService(
        uid: auth.getUser().uid, display: auth.getUser().displayName);
    showAlertDialog(BuildContext context, File image) {
      Widget cancelButton = FlatButton(
        child: Text("Discard"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      Widget continueButton = FlatButton(
        child: loading ? CircularProgressIndicator() : Text("Upload"),
        onPressed: () async {
          setState(() => loading = true);
          Navigator.of(context).pop();
          await db.saveImages(
              image,
              FirebaseFirestore.instance
                  .collection("images")
                  .doc(auth.getUser().uid)
                  .collection("userImages"));
          setState(() => loading = false);
        },
      );
      AlertDialog alert = AlertDialog(
        content: image != null
            ? Image.file(image)
            : Center(
                child: Text("No image selected"),
              ),
        actions: [
          cancelButton,
          continueButton,
        ],
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    return StreamProvider<QuerySnapshot>.value(
      initialData: null,
      value: db.images,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              auth.getUser().displayName == null
                  ? "Welcome!"
                  : "Welcome, " + auth.getUser().displayName + "!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('images')
                    .doc(auth.getUser().uid)
                    .collection('userImages')
                    .snapshots(),
                builder: (context, imageSnapshot) {
                  return imageSnapshot.hasData && !loading
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemCount: imageSnapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot orderData =
                                imageSnapshot.data.docs[index];
                            return ImageCard(
                                id: orderData.id,
                                index: index,
                                user: orderData.data()['user'],
                                img: orderData.data()['image']);
                          },
                        )
                      : Center(child: CircularProgressIndicator());
                }),
          ),
          RaisedButton(
            child: Text("Upload"),
            onPressed: () async {
              _image1 = await db.uploadImage();
              setState(() {
                _image = _image1;
              });
              showAlertDialog(context, _image);
            },
          ),
        ],
      ),
    );
  }
}
