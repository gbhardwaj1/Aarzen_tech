import 'package:edu_system/models/user.dart'; 
import 'package:edu_system/service/database.dart';
import 'package:edu_system/util/loading_home.dart'; 
import 'package:flutter/material.dart'; 
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart'; 

class RegisterPageImagePicker extends StatelessWidget {
  String buttonText = 'Press Ok';
  Image image;
  String description = 'Your file has been updated';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  User user;
  
  File _image;
  String url;
  bool isImageCapturedFromGalary = false;
  String _uploadedFileURL;
  UserProfile userProfileBean;
  Future getImagefromcamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  Future getImagefromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      isImageCapturedFromGalary = true;
    });
  }

  Future uploadFile() async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('gs://first-gb-db.appspot.com');
   
    // final  user1 = Provider.of<User>(context);
     //final 
      user =  Provider.of<User>(context, listen: false);
    
   print('user.uid >>>>>>>>>>>>>>>>>>>>>>>>>>>  '+user.uid);
    
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded ---');
    StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    url = (await downloadUrl.ref.getDownloadURL());
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
      });
      isImageCapturedFromGalary = false;
      _image = null;
    });

    try {
      print('Before db insert after successul authentication');
      await DatabaseService(uid: user.uid).updateUserInfo(
          userProfileBean.fullName,
          userProfileBean.city,
          userProfileBean.state,
          userProfileBean.phonenumber,
          userProfileBean.address,
          url);
      print('\n after db insert after successul User creation');
      showAlertDialog(context);
      // Alert(context: context, type: AlertType.success, title: "RFLUTTER", desc: "Im.").show();
      /*Alert(context: context,
            type: AlertType.warning,
            title: "RFLUTTER ALERT",
            desc: "Flutter is more awesome with RFlutter Alert.").show(); */

    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isURI = false;
    //#1 final 
     user =  Provider.of<User>(context, listen: false);
    bool loadingStatus = false;
    return StreamBuilder<UserProfile>(
        stream: DatabaseService(uid: user.uid).userProfileData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            userProfileBean = snapshot.data;
            if (userProfileBean != null) {
              if (userProfileBean.uri.length > 0) {
                //_image = File(userProfileBean.uri);
                isURI = true;
              }
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    isImageCapturedFromGalary
                        ? (Image.file(
                            _image,
                            height: 150,
                            fit: BoxFit.cover,
                          ))
                        : (_uploadedFileURL != null
                            ? (Image.network(
                                _uploadedFileURL,
                                height: 150,
                              ))
                            : Container(
                                child: Image.network(
                                userProfileBean.uri,
                                height: 150,
                              ))),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FloatingActionButton(
                      onPressed: getImagefromGallery,
                      tooltip: "Pick Image",
                      child: Icon(Icons.camera_alt),
                    )
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      (_image != null || isImageCapturedFromGalary)
                          ? RaisedButton(
                              child: Text('Upload File'),
                              onPressed: uploadFile,
                              color: Colors.cyan,
                            )
                          : Container(),
                    ]),
                Row(children: <Widget>[
                  Text(
                    "Please pick your recent image",
                    style: TextStyle(fontSize: 20),
                  ),
                ]),
              ],
            );
          } else {
            return Loading();
          }
        });
  }

  void showAlertDialog(BuildContext context) {
     
     showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('File Upload Status'),
        content: Text(
                'Your Image has been uploaded'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true)
                  .pop(); // dismisses only the dialog and returns nothing
            },
            child: new Text('OK'),
          ),
        ],
      ),
    );
     
  }
}
