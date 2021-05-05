import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_revised_avatar_project/models/user.dart';
import 'package:flutter_revised_avatar_project/screens/wrapper.dart';
import 'package:flutter_revised_avatar_project/services/auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<CustomUser>.value(
      initialData: null,
      value: AuthService().userStream,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
