import 'package:examanflutter/rdv.dart';
import 'package:flutter/material.dart';


class CardFood extends StatelessWidget {

  late String title;
 late String id;
  late String address;
  late String image;
   CardFood(
       this.id,
     this.title,
    
     this.image,
     this.address);
     
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return RDV(title, id);
            }));
        
      },
      child: Card(
        child: Column(
          children: [
            Container(
              child:  Image.network(image, height: 320),
            ),
                  Text(title, textScaleFactor: 2),
              const SizedBox(
                height: 10,
              ),
              Text("Adresse : "+address, textScaleFactor: 1)
          ],
        ),
        
      ),
    );
  }
}
