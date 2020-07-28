
import 'package:edu_system/aurhenticate/authenticate.dart';
import 'package:edu_system/models/user.dart';
import 'package:edu_system/screen/home/home_page.dart';
import 'package:edu_system/screen/home/home_page_p2.dart'; 
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
 

class Wrapper extends StatelessWidget {


  @override
  Widget build(BuildContext context) { 
    final user = Provider.of<User>(context); 
    if(user !=null){
      return  Home_P2();

    }else{
      return Authenticate();
    }
     

     
  }
}