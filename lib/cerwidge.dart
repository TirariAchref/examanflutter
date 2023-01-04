import 'package:flutter/material.dart';
class certwid extends StatelessWidget {
  const certwid( this.etat, this.qr_code, this.nom, this.code, this.prenom, this.email,{ Key? key }) : super(key: key);
  final String etat;
 final String    qr_code;
  final String   nom;
  final String   code;
  final String   prenom;
  final String   email;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Votre Nom est : "+nom),
         Text("Votre Prenom est : "+prenom),
 Text("Votre code est : "+code),
  Text("Votre email est : "+email),
   if(etat =="non vacciné")
      Text("Non Vaccine" , style: TextStyle(color: Colors.red),),
if(etat !="non vacciné")
     Text("Etat : Vacciné " ,style: TextStyle(color: Colors.green)),
  
     
   
      ],
      
    );
  }
}