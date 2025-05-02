import 'package:brew/screen/authenticate/authenticate.dart';
import 'package:brew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home/home.dart';
import 'package:brew/models/person.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Person?>(context);

    // Return either Home or Authenticate
    if (user == null) {
      return Authenticate();
    } else {
      return StreamProvider<Person?>.value(
        value: AuthService().user, // This should emit Person? from Firebase stream
        initialData: null,
        child: Home(),
      );
    }
  }
}
