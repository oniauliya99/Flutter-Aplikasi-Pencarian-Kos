import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:golekos/services/auth_services.dart';
import 'package:provider/provider.dart';
import 'wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final appName = 'Golekos';

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      // TODO: Check if any user data streams are available and return the data to indicate that the user is signed in or logged out.

      value: AuthService.firebaseUserStream,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: appName,
          theme: ThemeData(
            brightness: Brightness.light,
          ),
          home: Wrapper()),
    );
  }
}
