import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_system/models/user.dart';
import 'package:edu_system/screen/home/profile_home.dart'; 
import 'package:edu_system/screen/signin.dart';
import 'package:edu_system/service/auth.dart';
import 'package:edu_system/service/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthService _auth = AuthService();

    // final user = Provider.of<User>(context);
    return StreamProvider<List<UserInfoData>>.value(
      value: DatabaseService().userData,
      child: Scaffold(
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
                // _auth.signOut();
              },
              icon: Icon(Icons.person_outline),
              label: Text('Profile'),
            ),
            FlatButton.icon(
              onPressed: () async {
                // _auth.signOut();  
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
        body: Profile(),
      ),
    );
  }
}
