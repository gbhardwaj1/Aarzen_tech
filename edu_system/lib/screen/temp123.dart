import 'dart:ffi';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore    
import 'package:flutter/material.dart';    
import 'package:image_picker/image_picker.dart'; // For Image Picker    
import 'package:path/path.dart' as Path;  
import 'package:flutter/cupertino.dart'; 

void main() => runApp(MyTemp123());

class MyTemp123 extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File _image;
  String _uploadedFileURL;
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
    });
  }

  Future uploadFile() async {
    StorageReference storageReference1 = FirebaseStorage.instance
        .ref()
        .child('https://console.firebase.google.com/project/first-gb-db/storage/first-gb-db.appspot.com/files');
    
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('gs://first-gb-db.appspot.com');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text("Flutter Image Picker Example"),
      ), */
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Image Picker Example in Flutter------- ",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 200.0,
              child: Center(
                child: _image == null
                    ? Text("No Image is picked --------")
                    : Image.file(_image),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FloatingActionButton(
                onPressed: getImagefromcamera,
                tooltip: "pickImage",
                child: Icon(Icons.add_a_photo),
              ),
              FloatingActionButton(
                onPressed: getImagefromGallery,
                tooltip: "Pick Image",
                child: Icon(Icons.camera_alt),
              ),
               ],
          ),
              /* */
              Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _image != null
                  ? RaisedButton(
                      child: Text('Upload File'),
                      onPressed: uploadFile,
                      color: Colors.cyan,
                    )
                  : Container(),
              Text('Uploaded Image'),
              _uploadedFileURL != null
                  ? Image.network(
                      _uploadedFileURL,
                      height: 150,
                    )
                  : Container(),

              //** */
            ],
          )
        ],
      ),
    );
  }
}
