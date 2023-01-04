import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class Authentification extends StatefulWidget {
  const Authentification({ Key? key }) : super(key: key);

  @override
  _AuthentificationState createState() => _AuthentificationState();
}

class _AuthentificationState extends State<Authentification> {
   late String? _username;
  late String? _password;

  final String _baseUrl = "10.0.2.2:9090";

  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("S'authentifier"),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Form(
        key: _keyForm,
        child: ListView(
          children: [
           const SizedBox(
              height: 50,
            ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Image.asset("assets/images/logo.png", width: 460, height: 215)
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Code d'inscription"),
                  onSaved: (String? value) {
                    _username = value;
                  },
                  validator: (String? value) {
                    if(value == null || value.isEmpty) {
                      return "Le champ est requis";
                    }
                    else if(value.length != 3) {
                      return "Le champ doit avoir 3 caractères";
                    }
                    else {
                      return null;
                    }
                  },
                ),
              ),
              Row(
                children: [
                     Container(
              margin: const EdgeInsets.fromLTRB(100, 20, 30, 0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                child: const Text("Réinitialiser"),
                onPressed: () {
                _keyForm.currentState!.reset();
                   
                },
              )
            ),
               Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 50, 0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                child: const Text("Login"),
                onPressed: () {
                  if(_keyForm.currentState!.validate()) {
                    _keyForm.currentState!.save();

                    Map<String, dynamic> userData = {
                      "code": _username,
                     
                    };

                    Map<String, String> headers = {
                      "Content-Type": "application/json; charset=UTF-8"
                    };

                    http.post(Uri.http(_baseUrl, "/api/users/login"), headers: headers, body: json.encode(userData))
                        .then((http.Response response) async {
                          if(response.statusCode == 200) {
                            Map<String, dynamic> userData = json.decode(response.body);

                            // SharedPreferences
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString("userName", userData["_id"]);

                       

                         
                          

                            Navigator.pushReplacementNamed(context, "/home");
                          }
                          else if(response.statusCode == 401) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const AlertDialog(
                                  title: Text("Information"),
                                  content: Text("Username et/ou mot de passe incorrect !"),
                                );
                              },
                            );
                          }
                          
                    });
                  }
                },
              )
            ),
                ],
              )
           
            
          ],
        ),
      ),
      
    );
  }
}