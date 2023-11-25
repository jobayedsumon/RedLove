import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:redlove/helpers/alerts.dart';
import 'package:redlove/helpers/functions.dart';
import 'package:redlove/main.dart';
import 'package:redlove/screens/all_requests_screen.dart';
import 'package:redlove/screens/initial_screen.dart';
import 'package:sign_button/sign_button.dart';

final db = FirebaseFirestore.instance;

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'profile',
    'email',
  ],
);

Future<void> _handleSignOut() => _googleSignIn.disconnect();

class LoginScreen extends StatefulWidget {
  final navigatorKey;
  final snackBarKey;

  const LoginScreen({Key? key, this.navigatorKey, this.snackBarKey})
      : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<void> _handleSignIn() async {
    try {
      if (await _googleSignIn.isSignedIn()) {
        await _handleSignOut();
      }
      await _googleSignIn.signIn();
    } catch (error) {
      showError(snackBarKey.currentState!.context,
          'Could not logged you in! Please try again.');
    }
  }

  @override
  void initState() {
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      if (account != null) {
        var data = {
          "id": account.id,
          "name": account.displayName,
          "email": account.email,
          "image": account.photoUrl
        };
        try {
          db.collection('users').doc(account.id).set(data);
          setUser(jsonEncode(data));
          Navigator.pushAndRemoveUntil(
              navigatorKey.currentState!.context,
              MaterialPageRoute(builder: (context) => AllRequestsScreen()),
              (route) => false);
        } catch (exception) {
          print(exception);
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _googleSignIn.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Image(
                image: AssetImage('assets/images/logo.jpg'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hello! :)',
                      style: TextStyle(
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.red[900])),
                  Text('Connect your google account to get started.',
                      style: TextStyle(fontSize: 16.0, color: Colors.red[900])),
                  SizedBox(height: 30.0),
                  Center(
                    child: SignInButton(
                      buttonType: ButtonType.google,
                      buttonSize: ButtonSize.large,
                      onPressed: _handleSignIn,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
