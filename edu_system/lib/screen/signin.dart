import 'package:edu_system/screen/images_dart/images_banner.dart';
import 'package:edu_system/service/auth.dart';
import 'package:edu_system/util/loading_home.dart';
import 'package:edu_system/util/view_helper.dart';
import 'package:firebase_auth/firebase_auth.dart'; 
import 'package:flutter/material.dart'; 
import 'home/home_page_p2.dart';

class SignIn extends StatefulWidget {
  final Function testMyLogic;
  SignIn({this.testMyLogic});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final ViewHelper valHelper = ViewHelper();
  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();
  bool loadingStatus = false;
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loadingStatus
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            resizeToAvoidBottomPadding: false,
            appBar: AppBar(
              backgroundColor: Colors.cyan,
              title: Text(
                "Aarzen", // Intelligent Systems",
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
                  label: Text('Register'),
                ),
                FlatButton.icon(
                  onPressed: () async {
                    widget.testMyLogic();
                  },
                  icon: Icon(Icons.album),
                  label: Text('About Us'),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 0.0,
                      ),
                      Container(
                        child: Stack(
                          children: <Widget>[
                            ImageBanner('assets/images/bg_1.PNG'),
                          ],
                        ),
                      ),
                      Container(
                        child: Stack(
                          children: <Widget>[
                            valHelper.intputTextData(context,
                                "Welcome to Aarzen", 15.0, 25.0, 0.0, 0.0, 40),
                            valHelper.intputTextData(context, "Learnings", 15.0,
                                105.0, 0.0, 0.0, 40),
                            valHelper.intputTextData(
                                context, ".", 206.0, 67.0, 0.0, 0.0, 80),
                          ],
                        ),
                      ),
                      
                      Container(
                        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
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
                              obscureText: true,
                              decoration: valHelper.inputDecoration('Password'),
                              onChanged: (val) {
                                setState(() => password = val);
                              },
                            ),

                            SizedBox(
                              height: 5.0,
                            ),
                            Container(
                              alignment: Alignment(1.0, 0.0),
                              padding: EdgeInsets.only(top: 15, left: 20),
                              child: InkWell(
                                child: Text(
                                  'Forgot Password',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.cyan,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 40.0,
                            ),
                            ButtonTheme(
                              minWidth: 380.0,
                              height: 50.0,
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color: Colors.transparent)),
                                  color: Colors.cyan[400],
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                   onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                      setState(() => loadingStatus = true);
                                    Future result;
                                    try{
                                         result = _auth.signInWithEmailAndPassword( email, password);
                                       //        result = _auth.signIn( email, password);
                                    }catch(e){ 
                                      //result.catchError(onError)
                                       setState(() => {
                                            loadingStatus = false,
                                            error = 'Please specify a valid email'
                                          } );
                                    } 
                                  }
                                },
                                ),
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
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color: Colors.transparent)),
                                  color: Colors.cyan[400],
                                  onPressed: () {
                                    _auth
                                        .googleSignin(context)
                                        .whenComplete(() {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            // return Home();
                                            return Home_P2();
                                          },
                                        ),
                                      );
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image(
                                          image: AssetImage(
                                              "assets/images/google_logo.PNG"),
                                          height: 35.0),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text('Sign in with Google',
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 25.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            )),
                                      ),
                                    ],
                                  ),
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
            ),
          );
  }
}
