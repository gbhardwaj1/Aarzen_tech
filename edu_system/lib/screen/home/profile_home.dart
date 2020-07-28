 import 'package:edu_system/models/user.dart';
import 'package:edu_system/screen/home/home_page_p2.dart';
import 'package:edu_system/screen/images_dart/image_picker_reg.dart';
import 'package:edu_system/service/auth.dart';
import 'package:edu_system/service/database.dart';
import 'package:edu_system/util/loading_home.dart';
import 'package:edu_system/util/view_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget { 
  final ViewHelper valHelper = ViewHelper();
  UserProfile userProfileBean;
  double top = 0;
  AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserProfile>(
        stream: DatabaseService(uid: user.uid).userProfileData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            userProfileBean = snapshot.data;
            return Scaffold(
                //  home: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.cyan,
                  title: Text(
                    "Aarzen Intelligent Systems",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  elevation: 0.0,
                  actions: <Widget>[
                    FlatButton.icon(
                      onPressed: () {
                        // _auth.googleSignout().whenComplete(()
                        _auth.signOut().whenComplete(() {
                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            Navigator.of(context).push(
                                 MaterialPageRoute(
                                builder: (context) {
                                  //return MyApp();
                                   return Home_P2();
                                 },
                              ),  
                            );
                          });
                        });
                      },
                      icon: Icon(Icons.person),
                      label: Text('Logout'),
                    ),
                  ],
                ),
                body: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RegisterPageImagePicker(),
                        Container(
                          child: ListView(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: <Widget>[
                            DataTable(
                              columns: [
                                DataColumn(label: Text('Content')),
                                DataColumn(label: Text('Details')),
                              ],
                              rows: [
                                DataRow(cells: [
                                  DataCell(Text('Name')),
                                  DataCell(Text(userProfileBean.fullName)),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('City')),
                                  DataCell(Text(userProfileBean.city)),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('State')),
                                  DataCell(Text(userProfileBean.state)),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('Phone num')),
                                  DataCell(Text(userProfileBean.phonenumber)),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('Address')),
                                  DataCell(Text(userProfileBean.address)),
                                ]),
                              ],
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ));
          } else {
            return Loading();
          }
        });
  }

   
 }