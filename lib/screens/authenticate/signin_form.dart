import 'package:flutter/material.dart';
import 'package:flutter_revised_avatar_project/screens/authenticate/register_form.dart';
import 'package:flutter_revised_avatar_project/services/auth.dart';
import 'package:flutter_revised_avatar_project/shared_widgets/loading.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign-In To Your Account"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
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
                                "Sign-In",
                                style: TextStyle(color: Colors.white),
                              ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            dynamic result =
                                await _auth.signInEmail(email, password);
                            setState(() => loading = false);
                            if (result == null) {
                              setState(() {
                                error = "Either email or password is incorrect";
                              });
                            } else {
                              Navigator.pop(context);
                            }
                          }
                        })
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                error,
                style: TextStyle(color: Colors.red),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(fontSize: 18),
                  ),
                  GestureDetector(
                    child: Text(
                      "Create one!",
                      style: TextStyle(color: Colors.blue, fontSize: 18),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterForm()));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
