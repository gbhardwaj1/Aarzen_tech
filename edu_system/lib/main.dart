 
import 'package:edu_system/models/user.dart'; 
import 'package:edu_system/screen/home/welcome_part1.dart'; 
import 'package:edu_system/service/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
     return StreamProvider<User>.value(
        value: AuthService().user,
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(            
          ),
          home: SplashScreen1(),// Wrapper(),
        ),
      );  
    }
  }
 
