import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final formKey = GlobalKey<FormState>();
  String username = '', password = '', name = '', origin = '', errorField='';
  // HTTP:
  // Future<String> makeRequest() async {
  //   String url = "https://randomuser.me/api/";
  //   var response =
  //       await http.get(Uri.encodeFull(url), headers: {'Accept': 'application/json'});
  //       print(response.body);
  //   return response.body;
  // }

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
                onPressed: () async {
                  formKey.currentState.validate();
                  formKey.currentState.save();
                  print('Username is: $username and password is: $password');
                  // GET REQUEST:
                  // Create a function up there and use it below like this:
                  // var r = makeRequest();
                  //print(r);

                  // String expressGETBackendUrl = "http://localhost:3030/getData";
                  // var response = await http.get(
                  //   Uri.encodeFull(expressGETBackendUrl),
                  //   headers: {'Accept': 'application/json'},
                  // );
                  // var jsonResponse = convert.jsonDecode(response.body);
                  // setState(() {
                  //   name = jsonResponse['name'];
                  //   origin = jsonResponse['from'];
                  // });

                  //  POST REQUEST:
                  if (formKey.currentState.validate()) {
                    String expressPOSTBackendUrl =
                        "http://localhost:3030/flutter-login";
                    Map userInfo = {"username": username, "password": password};

                    var reponsePOST = await http.post(
                      expressPOSTBackendUrl,
                      headers: {'Accept': 'application/json'},
                      body: userInfo,
                    );
                    var postResponseJson = convert.jsonDecode(reponsePOST.body);
                    print(postResponseJson);
                    if (reponsePOST.statusCode == 200) {
                      setState(() {
                        name = postResponseJson['name'];
                        origin = postResponseJson['from'];
                        errorField = '';
                      });
                    } else {
                      setState(() {
                        name = '';
                        origin = '';
                        errorField = postResponseJson['error'];
                      });
                      
                    }
                  }

                  // http.get(
                  //   Uri.encodeFull(expressBackendUrl),
                  //   headers: {'Accept': 'application/json'},
                  // ).then((response) {
                  //   print(response.body);
                  //   var jsonResponse = convert.jsonDecode(response.body);
                  //   setState(() {
                  //     name = jsonResponse['name'];
                  //     origin = jsonResponse['from'];
                  //     print(jsonResponse['name']);
                  //     print(jsonResponse['from']);
                  //   });
                  // });
                },
                color: Colors.blueAccent,
              ),
              name.length > 0 ? Text('Name: $name') : Text(''),
              origin.length > 0 ? Text('Origin: $origin') : Text(''),
              errorField.length > 0 ? Text('Error: $errorField') : Text(''),
            ],
          ),
        ),
      ),
    ));
  }
}
