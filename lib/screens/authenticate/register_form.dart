import 'package:flutter/material.dart';
import 'package:flutter_revised_avatar_project/services/auth.dart';
import 'package:flutter_revised_avatar_project/shared_widgets/loading.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  String username = '';
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create an Account"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Username"),
                  validator: (val) => val.length < 3
                      ? "Username must be greater than 3 characters"
                      : null,
                  onChanged: (val) {
                    setState(() => username = val);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Email ID"),
                  validator: (val) =>
                      !val.contains("@") ? "Not a valid email ID" : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Password"),
                  validator: (val) => val.length < 6
                      ? "Password must be atleast 7 characters"
                      : null,
                  obscureText: true,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  color: Colors.blue,
                  child: loading
                      ? Loading(
                          color: Colors.white,
                        )
                      : Text(
                          "Register",
                          style: TextStyle(color: Colors.white),
                        ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() => loading = true);
                      dynamic result =
                          await _auth.registerEmail(username, email, password);
                      setState(() => loading = false);
                      if (result == null) {
                        setState(() {
                          error = "There was an error";
                        });
                      } else {
                        Navigator.pop(context);
                      }
                    }
                  },
                ),
                SizedBox(height: 20),
                Text(
                  error,
                  style: TextStyle(color: Colors.red),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
