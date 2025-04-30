import 'package:brew/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
   Home({super.key});

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text("Brew Crew"),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person, color: Colors.black,),
            label: Text('Logout',style: TextStyle(color: Colors.black),),
            onPressed: () async{
              await _authService.signOut();
            },
          )
        ],
      ),
    );
  }
}
