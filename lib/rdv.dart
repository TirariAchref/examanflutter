import 'dart:convert';

import 'package:examanflutter/rdvwidhet.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class RDV extends StatefulWidget {
  const RDV(this.name, this.id ,{ Key? key}) : super(key: key);
final String name ;
final String id;
  @override
  State<RDV> createState() => _RDVState();
}

class _RDVState extends State<RDV> {
  
  
    final String baseUrl = "10.0.2.2:9090";

 late Future<bool> fetchedUserAndMenu;
 final List<rrr> foods = [];
   late String username;
Future<bool> fetcheUserAndMenu() async {
     
 http.Response response = await http.get(Uri.http(baseUrl, "/api/pharmacies/rendez_vous/"+widget.id));
    List<dynamic> menusfromServer = json.decode(response.body);
    
    for (int i = 0; i < menusfromServer.length; i++) {
    
      foods.add(rrr(
          menusfromServer[i]["type"],
          menusfromServer[i]["date"],
       )
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
    return InkWell(
      
      onTap: () async {
         showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const AlertDialog(
                                 
                                  content: Text("Rendez_vous ajoute avec succes"),
                                );
                              },
                            );
    

      },
      child: 
      ListView.builder(
        
              itemCount: foods.length,
              itemBuilder: (context, index) {
                return rdvwidget(foods[index].type, foods[index].date);
              },
            ),
    );
  }
}

class rrr{
  late String type ;
   late String date ;

   rrr(this.type , this.date);
}