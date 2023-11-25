import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:redlove/screens/initial_screen.dart';
import 'package:redlove/screens/login_screen.dart';
import 'firebase_options.dart';
import 'helpers/functions.dart';

final GlobalKey<ScaffoldMessengerState> snackBarKey =
    GlobalKey<ScaffoldMessengerState>();

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  runApp(const RedLoveApp());
}

class RedLoveApp extends StatefulWidget {
  const RedLoveApp({super.key});

  @override
  State<RedLoveApp> createState() => _RedLoveAppState();
}

class _RedLoveAppState extends State<RedLoveApp> {
  @override
  initState() {
    super.initState();
    initializeFirebase();
  }

  initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: snackBarKey,
      title: 'RedLove',
      themeMode: ThemeMode.light,
      theme: ThemeData(colorSchemeSeed: Colors.red, useMaterial3: true),
      routes: {
        '/login': (context) => LoginScreen(
              navigatorKey: navigatorKey,
              snackBarKey: snackBarKey,
            )
      },
      home: FutureBuilder(
        future: isUserLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != false) {
              return InitialScreen();
            } else {
              return LoginScreen(
                  navigatorKey: navigatorKey, snackBarKey: snackBarKey);
            }
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
