
import 'package:flutter/material.dart';
class Temp extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
     //   appBar: AppBar(         title: Text('Set Full Screen Background Image')),
        body: Center(
 
            child: Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("https://flutter-examples.com/wp-content/uploads/2020/02/dice.jpg"),
              fit: BoxFit.cover)
              ),
              child: Center(child: Text('Set Full Screen Background Image in Flutter', 
                textAlign: TextAlign.center, style: 
                TextStyle(color: Colors.brown, fontSize: 25, fontWeight: FontWeight.bold),),)
               )
              )
            )
      );
  }
}