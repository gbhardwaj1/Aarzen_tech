import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_system/models/user.dart';
import 'package:edu_system/service/database.dart';
import 'package:edu_system/util/loading_home.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainDrawer123 extends StatefulWidget {
  @override
  _MainDrawer123State createState() => _MainDrawer123State();
}

class _MainDrawer123State extends State<MainDrawer123> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserProfile>(
        stream: DatabaseService(uid: user.uid).userProfileData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserProfile userProfileBeanData = snapshot.data;
            print('####################################');
            print(userProfileBeanData.uri);
            print(userProfileBeanData.address);
            print('####################################');
            return Drawer(
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    //  color: Theme.of(context).primaryColor,
                    color: Colors.cyan,
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: 100,
                            height: 90,
                            margin: EdgeInsets.only(top: 30),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(userProfileBeanData.uri),
                                // image: AssetImage( 'assets/images/gb1.PNG'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Text(
                            userProfileBeanData.fullName,
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            userProfileBeanData.city,
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                            ),
                          ),
                          /* Text(userProfileData.state,
                      style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.white,
                      ),
                    ),
                  Text(userProfileData.phonenumber,
                      style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.white,
                      ),
                    ),
                  Text(userProfileData.address,
                      style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.white,
                      ),
                    ), */
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Profile',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                        )),
                    onTap: null,
                  ),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Setting',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                        )),
                    onTap: null,
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
