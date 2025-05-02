import 'package:brew/decoration/loading.dart';
import 'package:brew/models/person.dart';
import 'package:brew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:brew/decoration/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formkey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  //form values
  String _currentName = 'check';
  String _currentSugars = '0';
  int _currentStrength = 100;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Person?>(context);

    if (user == null) {
      return const Center(child: Text('No user found.'));
    }

    return StreamBuilder<PersonData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          PersonData personData = snapshot.data!;
          return Form(
            key: _formkey,
            child: Column(
              children: <Widget>[
                Text(
                  'Update your brew settings.',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                TextFormField(
                  initialValue: personData.name,
                  decoration: textInputDecoration.copyWith(hintText: 'Name'),
                  validator:
                      (val) =>
                          (val == null || val.isEmpty)
                              ? 'Please enter a name'
                              : null,
                  onChanged:
                      (val) => setState(() {
                        _currentName = val;
                      }),
                ),
                SizedBox(height: 20),

                //dropper
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: 20,
                  ),
                  child: DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentSugars ?? personData.sugars,
                    items:
                        sugars.map((sugar) {
                          return DropdownMenuItem(
                            value: sugar,
                            child: Text('$sugar sugars'),
                          );
                        }).toList(),
                    onChanged: (val) {
                      setState(() => _currentSugars = val as String);
                    },
                  ),
                ),

                //slider
                Slider(
                  value: (_currentStrength ?? personData.strength).toDouble(),
                  min: 100,
                  max: 900,
                  divisions: 8,
                  activeColor:
                      Colors.brown[(_currentStrength ?? personData.strength)],
                  //inactiveColor: Colors.brown[(_currentStrength ?? personData.strength)],
                  onChanged: (val) {
                    setState(() => _currentStrength = val.round());
                  },
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown[600],
                  ),
                  onPressed: () async {
                    if (_formkey.currentState?.validate() == true) {
                      await DatabaseService(uid: user.uid).updateUserData(
                        _currentSugars ?? personData.sugars,
                        _currentName ?? personData.name,
                        _currentStrength ?? personData.strength,
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Update', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
