import 'package:flutter/material.dart';

class rdvwidget extends StatelessWidget {
  const rdvwidget( this.type, this.date,{ Key? key }) : super(key: key);

final String type;
final String date ;
  @override
  Widget build(BuildContext context) {
    return Column(
      
      children: [
         Text(type,textScaleFactor: 2,),
        Text(date,textScaleFactor: 2,),
      ],
      
    );
  }
}