
import 'dart:convert';

import 'package:examanflutter/cerwidge.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class certificat extends StatefulWidget {
  const certificat({ Key? key }) : super(key: key);

  @override
  _certificatState createState() => _certificatState();
}

class _certificatState extends State<certificat> {

  
    final String baseUrl = "10.0.2.2:9090";

 late Future<bool> fetchedUserAndMenu;
 final List<cc> foods = [];
   late String username;
Future<bool> fetcheUserAndMenu() async {
   
   SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString("userName")!;
    print(username);
 http.Response response = await http.get(Uri.http(baseUrl, "/api/certificate/"+username));
   dynamic menusfromServer = json.decode(response.body);
    print(menusfromServer);
   
      foods.add(cc(
          menusfromServer["etat"],
           "http://10.0.2.2:9090/"+ menusfromServer["qr_code"],
            menusfromServer["nom"],
          menusfromServer["code"],
           menusfromServer["prenom"],
             menusfromServer["email"],)
      );
    

 
    return true;
}
  @override
  void initState() {
  fetchedUserAndMenu = fetcheUserAndMenu();
  
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:fetchedUserAndMenu ,
      builder: (context, AsyncSnapshot<bool>  snapshot){
      if(snapshot.hasData) {
      
        return Scaffold(
       
       
        body: ListView.builder(
              itemCount: foods.length,
              itemBuilder: (context, index) {
                return certwid(foods[index].etat, foods[index].qr_code,foods[index].nom,foods[index].code, foods[index].prenom, foods[index].email);
              },
            ),
        
      );
     } else { 
          return const Center(child: CircularProgressIndicator(),);
        }
      }
    );
  }
}

class cc {
  late String etat;
 late String    qr_code;
  late String   nom;
  late String   code;
  late String   prenom;
  late String   email;

  cc(this.etat , this.qr_code , this.nom,this.code,this.prenom,this.email);
}