 
import 'package:edu_system/models/user.dart';
import 'package:edu_system/screen/wrapper_home.dart';
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
          home: Wrapper(),
        ),
      );  
    }
  }
 
