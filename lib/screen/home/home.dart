import 'package:brew/models/brew.dart';
import 'package:brew/models/person.dart';
import 'package:brew/screen/home/settings_form.dart';
import 'package:brew/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:brew/services/database.dart';
import 'package:provider/provider.dart';
import 'package:brew/screen/home/brew_list.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Person>(context);

    void _showSettingsPanel() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Provider(
                create: (_) => Person(uid: user.uid),
                child: SettingsForm(),
              ),
            ),
          );
        },
      );
    }

    return StreamProvider<List<Brew>?>.value(
      value: DatabaseService(uid: '').brews,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text("Brew Crew"),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.person, color: Colors.black),
              label: Text('Logout', style: TextStyle(color: Colors.black)),
              onPressed: () async {
                await _authService.signOut();
              },
            ),

            TextButton.icon(
              onPressed: () {
                _showSettingsPanel();
              },
              label: Text('Settings', style: TextStyle(color: Colors.black)),
              icon: Icon(Icons.settings_outlined, color: Colors.black),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: BrewList(),
        ),
      ),
    );
  }
}
