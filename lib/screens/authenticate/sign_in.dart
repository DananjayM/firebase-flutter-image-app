import 'package:flutter/material.dart';
import 'package:flutter_revised_avatar_project/screens/authenticate/signin_form.dart';
import 'package:flutter_revised_avatar_project/shared_widgets/loading.dart';
import 'package:flutter_revised_avatar_project/services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Online Gallery"),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: Center(child: Text("Sign-In")),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignInForm()));
                },
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width * 0.5,
                child: Row(children: <Widget>[
                  Expanded(
                      child: Divider(
                    color: Colors.black,
                  )),
                  Text(" OR "),
                  Expanded(
                      child: Divider(
                    color: Colors.black,
                  )),
                ]),
              ),
              RaisedButton(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: Center(
                      child: loading
                          ? Loading(
                              color: Colors.blue,
                            )
                          : Text("Sign-In as Guest")),
                ),
                onPressed: () async {
                  setState(() => loading = true);
                  dynamic result = await _auth.signInAnon();
                  setState(() => loading = false);
                  if (result == null) {
                    print("Error");
                  } else {
                    print("Signed In");
                    print(result.uid);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
