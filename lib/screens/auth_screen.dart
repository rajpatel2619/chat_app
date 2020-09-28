import 'package:chat_app/widgets/auth/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(String email, String password, String userName,
      bool isLogin, BuildContext ctx) async {
    UserCredential authResult;
    try {
      if (isLogin) {
        setState(() {
          _isLoading = true;
        });
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        setState(() {
          _isLoading = true;
        });
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user.uid)
            .set({'username': userName, 'email': email});
      }
    } on PlatformException catch (err) {
      var message = 'An error occured ,please check your credentials';
      if (err.message != null) {
        message = err.message;
      }
      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(ctx).errorColor,
      ));
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        _isLoading = false;
      });
      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text(err.message.toString()),
        backgroundColor: Theme.of(ctx).errorColor,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm, _isLoading),
    );
  }
}
