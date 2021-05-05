import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_revised_avatar_project/models/imageModel.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class DatabaseService {
  final String uid, display;
  File _image;
  DatabaseService({this.uid, this.display});
  //collection reference
  final CollectionReference imageCollection =
      FirebaseFirestore.instance.collection('images');
  Future uploadImage() async {
    ImagePicker picker = ImagePicker();
    PickedFile pickedFile;
    pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      return _image;
    } else {
      return null;
    }
  }

  Future createImage() async {
    return await imageCollection
        .doc(uid)
        .collection('userImages')
        .add({"user": display, "test": "123"});
  }

  Future saveImages(File _image, CollectionReference ref) async {
    String imageURL = await uploadFile(_image);
    ref.add({"user": display, "image": imageURL});
  }

  Future<String> uploadFile(File _image) async {
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('images/$uid/${basename(_image.path)}');
    UploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask;
    print('File Uploaded');
    String returnURL;
    await storageReference.getDownloadURL().then((fileURL) {
      returnURL = fileURL;
    });
    return returnURL;
  }

  //image list from snapshot
  List<imageModel> _imageModelListFromSnapshot(QuerySnapshot images) {
    FirebaseFirestore.instance.collection("images").get().then((images) {
      images.docs.forEach((result) {
        FirebaseFirestore.instance
            .collection("images")
            .doc(result.id)
            .collection("userImages")
            .get()
            .then((images) {
          images.docs.forEach((result) {
            return imageModel(
                user: result.data()['user'] ?? null,
                test: result.data()['test'] ?? null);
          });
        });
      });
    });
  }

  //get image stream
  Stream<QuerySnapshot> get images {
    return imageCollection.snapshots();
  }
}
