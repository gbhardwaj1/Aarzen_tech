 
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_system/util/form_helper.dart';
import 'package:firebase_storage/firebase_storage.dart'; 

import 'package:edu_system/service/auth.dart';
import 'package:edu_system/util/loading_home.dart';
import 'package:edu_system/util/view_helper.dart';
import 'package:flutter/material.dart';

class Register_1_ extends StatefulWidget {
  final Function testMyLogic;
  Register_1_({this.testMyLogic});

  @override
  _Register_1_State createState() => _Register_1_State();
}

class _Register_1_State extends State<Register_1_> {
   
  final AuthService _auth = AuthService();
  final ViewHelper valHelper = ViewHelper();
  FormHelper formHelper = FormHelper();
  Uint8List imageBytes;
  String errorMsg; 
  final _formKey = GlobalKey<FormState>();
  bool loadingStatus = false; 

  

  @override
  Widget build(BuildContext context) { 

    return loadingStatus
        ? Loading()
        : Scaffold( 
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
                  onPressed: () async {
                    widget.testMyLogic();
                  },
                  icon: Icon(Icons.person),
                  label: Text('SignIn'),
                ),
              ],
            ),
           
            body: FormHelper()  
          );
  }
}
