import 'package:flutter/material.dart';
import 'package:flutter_revised_avatar_project/models/user.dart';
import 'package:flutter_revised_avatar_project/screens/authenticate/authenticate.dart';
import 'package:flutter_revised_avatar_project/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return home or authenticate widget
    final streamUser = Provider.of<CustomUser>(context);
    return streamUser == null ? Authenticate() : Home();
  }
}
