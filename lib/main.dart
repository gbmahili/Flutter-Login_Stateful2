import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final formKey = GlobalKey<FormState>();
  String username = '', password = '';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Container(
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'User Name',
                  labelText: 'User Name *',
                ),
                onSaved: (String value) {
                  username = value;
                },
                validator: (String value) {
                  return value.contains('@') ? 'Do not use the @ char.' : null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Password',
                  labelText: 'Password',
                ),
                onSaved: (String value) {
                  password = value;
                },
                validator: (String value) {
                  return value.contains('@') ? 'Do not use the @ char.' : null;
                },
              ),
              RaisedButton(
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  formKey.currentState.validate();
                  formKey.currentState.save();
                  print('Username is: $username and password is: $password');
                },
                color: Colors.blueAccent,
              )
            ],
          ),
        ),
      ),
    ));
  }
}
