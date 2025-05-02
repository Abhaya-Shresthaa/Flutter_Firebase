import 'package:brew/decoration/constants.dart';
import 'package:brew/decoration/loading.dart';
import 'package:brew/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  const SignIn({super.key, required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("Sign in to Brew Crew"),
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person, color: Colors.black,),
            label: Text('Register', style: TextStyle(color: Colors.black)),
            onPressed: () {
              widget.toggleView();
            },
          ),
        ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                TextFormField(
                  decoration: textInputDecoration,
                  validator: (val) => (val == null || val.isEmpty) ? 'Enter an email' : null,
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                ),
                //password field
                SizedBox(height: 20),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),
                  validator: (val) => (val == null || val.length < 6) ? 'Enter a password with more than 6 chars' : null,
                  obscureText: true,
                  onChanged: (val) {
                    setState(() {
                      password = val;
                    });
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown[600],
                  ),
                  onPressed: () async {
                      if (_formKey.currentState?.validate() == true) {
                        setState(() {
                          loading = true;
                        });
                        dynamic result = await _authService.signInWithEmailAndPassword(email, password);
                        if(result == null){
                          setState(() {
                            error = 'Could not SignIn with provided data';
                            loading = false;
                          });
                        }
                      }
                  },
                  child: Text('Sign in', style: TextStyle(color: Colors.white)),
                ),
                SizedBox(height: 12,),
                Text(
                  error,style: TextStyle(color: Colors.red, fontSize: 17),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
