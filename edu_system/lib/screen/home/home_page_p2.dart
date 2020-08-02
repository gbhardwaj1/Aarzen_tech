    
import 'package:edu_system/screen/home/drawer_home_part2.dart'; 
import 'package:edu_system/screen/home/profile_home_new.dart';
import 'package:edu_system/screen/images_dart/images_banner.dart'; 
import 'package:edu_system/screen/signin.dart'; 
import 'package:edu_system/service/auth.dart'; 
import 'package:flutter/material.dart'; 

class Home_P2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthService _auth = AuthService();
     
 
    return  Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: Text(
            "Aarzen Intelligent Systems !",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () async { 
                //return ProfileHomeGB();
                //return SignIn();

                
                Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return   ProfileHomeGB();
                      },
                    ),
                  );
              },
              icon: Icon(Icons.person_outline),
              label: Text('Profile'),
            ),
            FlatButton.icon(
              onPressed: () async {
                // _auth.signOut();
                print("Trying to logout");
                //print(_auth.signOut());
                 
                _auth.googleSignout().whenComplete(() {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return SignIn();
                      },
                    ),
                  );
                });
                
              },
              icon: Icon(Icons.person),
              label: Text('Logout'),
            ),
          ],
        ),

         drawer: MainDrawer123(),
       // body: Text('Wait for some new update'),
       body:  ImageBanner('assets/images/bg_1.PNG'),
       
    );
  }
}
