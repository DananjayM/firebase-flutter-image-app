import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_revised_avatar_project/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  //create CustomUser object based on Firebase User
  CustomUser _userFromFirebaseUser(User firebaseUser) {
    return firebaseUser != null ? CustomUser(uid: firebaseUser.uid) : null;
  }

  //auth change user stream
  Stream<CustomUser> get userStream {
    return _auth
        .authStateChanges()
        .map((User firebaseuser) => _userFromFirebaseUser(firebaseuser));
  }

  //sign-in anonymously
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User firebaseUser = result.user;
      print(_auth.currentUser);
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign-in with email and password
  Future signInEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User firebaseUser = result.user;
      user = result.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and password
  Future registerEmail(String username, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User firebaseUser = result.user;
      await (updateUsername(username));
      print(firebaseUser);
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Add username
  Future updateUsername(String username) async {
    try {
      await _auth.currentUser.updateProfile(displayName: username);
    } catch (e) {
      print("Username taken");
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  User getUser() {
    return _auth.currentUser;
  }
}
