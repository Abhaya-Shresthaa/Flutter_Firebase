import 'package:brew/models/person.dart';
import 'package:brew/screen/authenticate/authenticate.dart';
import 'package:brew/screen/wrapper.dart';
import 'package:brew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamProvider<Person?>.value(
        value: AuthService().user,
        initialData: null, // Optional, ensures the stream has an initial value
        child: Wrapper(),
      ),
    );
  }
}
