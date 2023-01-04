
import 'package:examanflutter/auth.dart';
import 'package:examanflutter/cer.dart';
import 'package:examanflutter/dose.dart';
import 'package:examanflutter/main.dart';
import 'package:examanflutter/pharmacie.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class NavigationTab extends StatelessWidget {
  const NavigationTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.red,
          title: const Text("Evax",)
          ,centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.health_and_safety),
                text: "Mes doses",
              ),
              Tab(
                icon: Icon(Icons.local_pharmacy),
                text: "Pharmacies",
              ),
                 Tab(
                icon: Icon(Icons.qr_code),
                text: "Certificats",
              )

            ],
          ),
        ),
        drawer: Drawer(
          
          child: Column(
            children: [
              AppBar(
                  iconTheme: IconThemeData(color: Colors.white),
                  backgroundColor: Colors.red,
              ),
              ListTile(
                title: Row(
                  children: const [
                    Icon(Icons.edit),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Historique")
                  ],
                ),
                onTap: () {
                
                },
              ),
              ListTile(
                title: Row(
                  children: const [
                    Icon(Icons.vertical_align_bottom),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Se deconnecter")
                  ],
                ),
                onTap: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
  
   prefs.remove("userName");
                 Navigator.pushReplacementNamed(context, "/");
                },
              )
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Dose(), Pharmacie(),certificat()
          ],
        ),
      ),
    );
  }
}
