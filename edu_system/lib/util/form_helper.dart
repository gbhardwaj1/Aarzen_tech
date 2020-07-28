import 'dart:typed_data';
import 'dart:io';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_system/screen/images_dart/image_picker_reg.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'package:edu_system/service/auth.dart';
import 'package:edu_system/util/view_helper.dart';
import 'package:flutter/material.dart';

class FormHelper extends StatefulWidget {
  @override
  _FormHelperState createState() => _FormHelperState();
}

class _FormHelperState extends State<FormHelper> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  final ViewHelper valHelper = ViewHelper();
  FormHelper formHelper = FormHelper(); 
  File _image;
  String _uploadedFileURL;


/*  -- */

  final FirebaseStorage storage = FirebaseStorage(
      app: Firestore.instance.app,
      storageBucket: 'gs://first-gb-db.appspot.com');

  Uint8List imageBytes;
  String errorMsg;

/* -- */
  bool loadingStatus = false;
  String email = '';
  String password = '';
  String error = '';

  String fullName = '';
  String city = '';

  String state = '';
  String phonenumber = '';
  String address = ''; 
  //
  Widget buildForm() {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
                  child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //_buildImageField(),
            //  RegisterPageImagePicker(),
              _buildEmailField(),
              _buildPasswordField(),
              _buildFullNameField(),
              _buildCityField(),
              _buildStateField(),
              _buildPhonenumField(),
              _buildAddressField(),
               SizedBox(height: 40.0),
              _buildSubmitButton(),
            ],
          ),
        ));
  }

  Widget _buildImageField() {
      
     RegisterPageImagePicker();
     
 
  }

  Widget _buildEmailField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Email'),
      validator: (val) => val.isEmpty ? 'Enter an Email' : null,
      onChanged: (val) {
        setState(() => email = val);
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Password'),
      validator: (val) => val.length < 6 ? 'Enter the password' : null,
      onChanged: (val) {
        setState(() => password = val);
      },
      obscureText: true,
    );
  }

  Widget _buildFullNameField() {
    return TextFormField(
        decoration: InputDecoration(labelText: 'Full Name'),
        validator: (val) => val.isEmpty ? 'fullName' : null,
        onChanged: (val) {
          setState(() => fullName = val);
        });
  }

  Widget _buildCityField() {
    return TextFormField(
        decoration: InputDecoration(labelText: 'City'),
        validator: (val) => val.isEmpty ? 'City' : null,
        onChanged: (val) {
          setState(() => city = val);
        });
  }

  Widget _buildStateField() {
    return TextFormField(
        decoration: InputDecoration(labelText: 'State'),
        validator: (val) => val.isEmpty ? 'State' : null,
        onChanged: (val) {
          setState(() => state = val);
        });
  }

  Widget _buildPhonenumField() {
    return TextFormField(
        decoration: InputDecoration(labelText: 'Phoune-num'),
        validator: (val) => val.isEmpty ? 'phonenumber' : null,
        onChanged: (val) {
          setState(() => phonenumber = val);
        });
  }

  Widget _buildAddressField() {
    return TextFormField(
        decoration: InputDecoration(labelText: 'Address'),
        validator: (val) => val.isEmpty ? 'Enter an address' : null,
        onChanged: (val) {
          setState(() => address = val);
        });
  }

  Widget _buildSubmitButton() {
    return ButtonTheme(
      minWidth: 380.0,
      height: 50.0,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: Colors.transparent)),
        color: Colors.cyan[400],
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            setState(() => loadingStatus = true);
            dynamic result = _auth.registerWithEmailAndPassword1(
                email, password, fullName, city, state, phonenumber, address);
            if (result == null) {
              setState(() => {
                    loadingStatus = true,
                    error = 'Please specify a valid email'
                  });
            }  
          }
        },
        child: Text(
          'Register',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  //
  @override
  Widget build(BuildContext context) {
    return buildForm();
  }
}
