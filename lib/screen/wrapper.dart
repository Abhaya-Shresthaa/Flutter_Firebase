import 'package:brew/screen/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home/home.dart';
import 'package:brew/models/person.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<Person?>(context);

    //return either Home or Authenticate widget
    if (user == null){
      return Authenticate();
    }
    else {
      return Home();
    }
  }
}
