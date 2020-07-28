
import 'package:edu_system/screen/register_home.dart';
import 'package:edu_system/screen/register_home_p2.dart';
import 'package:edu_system/screen/signin.dart';
import 'package:flutter/material.dart';   
class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  
  bool showSignIn = true;
  void toggleView(){
    setState(() => showSignIn =!showSignIn );
  }
  @override
  Widget build(BuildContext context) {
    if(showSignIn){
      return   SignIn(testMyLogic :toggleView);
    }else{
      return   Register_1_(testMyLogic :toggleView);
    }
    
     
  }
}