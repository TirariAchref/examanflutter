import 'dart:convert';

import 'package:examanflutter/pharwidget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class Pharmacie extends StatefulWidget {
  const Pharmacie({ Key? key }) : super(key: key);

  @override
  _PharmacieState createState() => _PharmacieState();
}

class _PharmacieState extends State<Pharmacie> {
  
    final String baseUrl = "10.0.2.2:9090";

 late Future<bool> fetchedUserAndMenu;
 final List<phar> foods = [];
Future<bool> fetcheUserAndMenu() async {
   
 http.Response response = await http.get(Uri.http(baseUrl, "/api/pharmacies/list"));
    List<dynamic> menusfromServer = json.decode(response.body);
    for (int i = 0; i < menusfromServer.length; i++) {
      foods.add(phar(
          menusfromServer[i]["_id"],
          menusfromServer[i]["title"],
           menusfromServer[i]["address"],
             "http://10.0.2.2:9090/"+ menusfromServer[i]["image"],)
      );
    } 

 
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
                return CardFood(foods[index]._id,foods[index].title, foods[index].image, foods[index].address);
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

class phar{
  late   String _id;
  late   String title;
   late      String address;
    late    String image;
    phar(this._id,this.title,this.address,this.image);
}