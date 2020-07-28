import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'package:edu_system/service/auth.dart';
import 'package:edu_system/util/loading_home.dart';
import 'package:edu_system/util/view_helper.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function testMyLogic;
  Register({this.testMyLogic});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final ViewHelper valHelper = ViewHelper();

/*  -- */

  final FirebaseStorage storage = FirebaseStorage(
      app: Firestore.instance.app,
      storageBucket: 'gs://first-gb-db.appspot.com');

  Uint8List imageBytes;
  String errorMsg;

/* -- */
  final _formKey = GlobalKey<FormState>();
  bool loadingStatus = false;
  String email = '';
  String password = '';
  String error = '';

  String fullName = '';
  String city = '';

  String state = '';
  String phonenumber = '';
  String address = '';

  _MyHomePageState() { 
    storage
        .ref()
        .child('assets/images/bg_1.PNG')
        .getData(10000000)
        .then((data) => setState(() {
              imageBytes = data;
            }))
        .catchError((e) => setState(() {
              errorMsg = e.error;
            }));
 
  }

  @override
  Widget build(BuildContext context) {
    var img = imageBytes != null
        ? Image.memory(
            imageBytes,
            fit: BoxFit.cover,
          )
        : Text(errorMsg != null ? errorMsg : "Loading...");

    //final String phpEndPoint = 'http://192.168.43.42/phpAPI/image.php';
//final String nodeEndPoint = 'http://192.168.43.42:3000/image';
    File file;

    void _choose() async {
      // file = await ImagePicker.pickImage(source: ImageSource.camera);
      file = await ImagePicker.pickImage(source: ImageSource.gallery);
    }

    void _upload() {
      if (file == null) return;
      String base64Image = base64Encode(file.readAsBytesSync());
      String fileName = file.path.split("/").last;

      http.post("--", body: {
        "image": base64Image,
        "name": fileName,
      }).then((res) {
        print(res.statusCode);
      }).catchError((err) {
        print(err);
      });
    }

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
            body: Container(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    img,
                    /* Container(
                      child: Stack(
                        children: <Widget>[
                          valHelper.intputTextData(context, "Welcome to Aarzen",
                              15.0, 80.0, 0.0, 0.0, 40),
                          valHelper.intputTextData(
                              context, "Learnings", 15.0, 160.0, 0.0, 0.0, 40),
                          valHelper.intputTextData(
                              context, ".", 206.0, 122.0, 0.0, 0.0, 80),
                        ],
                      ),
                    ), 
                    
                        final File image = await ImagePicker.pickImage(source: imageSource);

                        // getting a directory path for saving
                          final String path = await getApplicationDocumentsDirectory().path;

                            // copy the file to a new path
                            final File newImage = await image.copy('$path/image1.png');

                            setState(() {
                              _image = newImage;
                                        });
                    
                    
                    */
                    Container(
                      padding: EdgeInsets.only(top: 35, left: 20, right: 20),
                      child: Column(children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RaisedButton(
                              onPressed: _choose,
                              child: Text('Choose Image'),
                            ),
                            SizedBox(width: 10.0),
                            RaisedButton(
                              onPressed: _upload,
                              child: Text('Upload Image'),
                            )
                          ],
                        ),
                        file == null
                            ? Text('No Image Selected')
                            : Image.file(file)
                      ]),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 35, left: 20, right: 20),
                      child: Column(
                        children: <Widget>[
                          // SizedBox(height:10.0),
                          TextFormField(
                              decoration: valHelper.inputDecoration('Email'),
                              validator: (val) =>
                                  val.isEmpty ? 'Enter an Email' : null,
                              onChanged: (val) {
                                setState(() => email = val);
                              }),
                          SizedBox(
                            height: 10.0,
                          ),

                          TextFormField(
                            validator: (val) =>
                                val.length < 6 ? 'Enter the password' : null,
                            onChanged: (val) {
                              setState(() => password = val);
                            },
                            obscureText: true,
                            decoration: valHelper.inputDecoration('Password'),
                          ),

                          SizedBox(height: 10.0),
                          TextFormField(
                              decoration:
                                  valHelper.inputDecoration('full Name'),
                              validator: (val) =>
                                  val.isEmpty ? 'fullName' : null,
                              onChanged: (val) {
                                setState(() => fullName = val);
                              }),

                          SizedBox(height: 10.0),
                          TextFormField(
                              decoration: valHelper.inputDecoration('city'),
                              validator: (val) => val.isEmpty ? 'City' : null,
                              onChanged: (val) {
                                setState(() => city = val);
                              }),
                          SizedBox(height: 10.0),
                          TextFormField(
                              decoration: valHelper.inputDecoration('state'),
                              validator: (val) => val.isEmpty ? 'State' : null,
                              onChanged: (val) {
                                setState(() => state = val);
                              }),
                          SizedBox(height: 10.0),
                          TextFormField(
                              decoration:
                                  valHelper.inputDecoration('phonenumber'),
                              validator: (val) =>
                                  val.isEmpty ? 'phonenumber' : null,
                              onChanged: (val) {
                                setState(() => phonenumber = val);
                              }),
                          SizedBox(height: 10.0),
                          TextFormField(
                              decoration: valHelper.inputDecoration('address'),
                              validator: (val) =>
                                  val.isEmpty ? 'Enter an address' : null,
                              onChanged: (val) {
                                setState(() => address = val);
                              }),
                            
                          SizedBox(
                            height: 40.0,
                          ),
                          ButtonTheme(
                            minWidth: 380.0,
                            height: 50.0,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.transparent)),
                              color: Colors.cyan[400],
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() => loadingStatus = true);

                                  dynamic result =
                                      _auth.registerWithEmailAndPassword1(
                                          email,
                                          password,
                                          fullName,
                                          city,
                                          state,
                                          phonenumber,
                                          address);
                                  if (result == null) {
                                    setState(() => {
                                          loadingStatus = true,
                                          error = 'Please specify a valid email'
                                        });
                                  }
                                }
                              },
                            ),
                          ),

                          //

                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            error,
                            style: TextStyle(color: Colors.red, fontSize: 15),
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                          Container(
                            height: 50.0,
                            color: Colors.transparent,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                  width: 1.0,
                                ),
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'New to Aarzen ?',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                              InkWell(
                                onTap: () {},
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.cyan,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
