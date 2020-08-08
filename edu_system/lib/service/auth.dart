 
import 'package:edu_system/models/user.dart'; 
import 'package:edu_system/service/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart'; 
import 'package:google_sign_in/google_sign_in.dart'; 

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  User _userFromFireBaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFireBaseUser);
  }
  // Sign in Anon
  // Sign in with Email and Password

   Future < FirebaseUser >   signInWithEmailAndPassword(String email, String password) async {
    
      String errorMessage;
      FirebaseUser user;
    try {
        
         //FirebaseUser user =   _auth.signInWithEmailAndPassword(email: email, password: password);    
       
        user =   (await _auth.signInWithEmailAndPassword(email: email, password: password)).user;
       
        assert(user != null);    
        assert(await user.getIdToken() != null);    
        final FirebaseUser currentUser = await _auth.currentUser();    
        assert(user.uid == currentUser.uid);    
       
    } catch (error) { 
        errorMessage=null;
    switch (error.code) {
      case "ERROR_INVALID_EMAIL":
        errorMessage = "Your email address appears to be malformed.";
        break;
      case "ERROR_WRONG_PASSWORD":
        errorMessage = "Your password is wrong.";
        break;
      case "ERROR_USER_NOT_FOUND":
        errorMessage = "User with this email doesn't exist.";
        break;
      case "ERROR_USER_DISABLED":
        errorMessage = "User with this email has been disabled.";
        break;
      case "ERROR_TOO_MANY_REQUESTS":
        errorMessage = "Too many requests. Try again later.";
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
        errorMessage = "Signing in with Email and Password is not enabled.";
        break;
      default:
        errorMessage = "An undefined Error happened.";
    }
        //return null;error.code 
    } if (errorMessage != null) { //response.statusCode
      print('errorMessage  '+errorMessage);
      throw Future< FirebaseUser >.error(errorMessage);
    //return  null; //  Future< FirebaseUser >.error(errorMessage);
  }
  print('Coming till here when wrong password ');
  return user;
  }

  
  // Sign in with Email and Password
 
    

  // Register with email and Password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      //print(object)
      /*await DatabaseService(uid: user.uid).updateUserInfo( 'firstname', 'lastname', 'city',
 'state' , 'phonenumber' , 'address'); */
      return _userFromFireBaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future registerWithEmailAndPassword1(
      String email,
      String password,
      String fullName,
      String city,
      String state,
      String phonenumber,
      String address) async {
    try { 
      
      print('Before db create User With Email And Password !!!!  ' );
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
 
      FirebaseUser user = result.user;
      print('Before db insert after successul authentication');
      await DatabaseService(uid: user.uid)
          .updateUserInfo(fullName, city, state, phonenumber, address,"");
      print('**********************************************');
      print('\n after db insert after successul User creation');
 
      return _userFromFireBaseUser(user);
    } catch (e) {
     
      print(e.toString());
      return null;
    }
  }

  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFireBaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// Sign out

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // G Drive Intrigration
  Future<FirebaseUser> googleSignin(BuildContext context) async {
    FirebaseUser currentUser;
       AuthResult result;
    try {
      print('inside googleSignin ');
      final GoogleSignIn _googleSignIn = GoogleSignIn(); 
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn(); 
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
          
    print('before  GoogleAuthProvider 3');
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
        result = await _auth.signInWithCredential(credential);
       
      print('after  signInWithCredential ');
      assert(result.user.email != null);
      assert(result.user.displayName != null);
      assert(!result.user.isAnonymous);
      assert(await result.user.getIdToken() != null);
      currentUser = await _auth.currentUser();
      assert(result.user.uid == currentUser.uid);
      print(result.user.uid +">>>>>>>>>>>>>>>>>>>>>>>>> 1 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<  "+currentUser.uid);
      print(result.user);
      print("User Name : ${currentUser.displayName}");
       
    } catch (e) {
      print(e.toString());
      return currentUser;
    } 

      return result.user;
  }


Future<String> signInWithGoogle() async {

  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

  final GoogleSignInAuthentication googleSignInAuthentication =

      await googleSignInAccount.authentication;



  final AuthCredential credential = GoogleAuthProvider.getCredential(

    accessToken: googleSignInAuthentication.accessToken,

    idToken: googleSignInAuthentication.idToken,

  );



  final AuthResult authResult = await _auth.signInWithCredential(credential);

  final FirebaseUser user = authResult.user;



  assert(!user.isAnonymous);

  assert(await user.getIdToken() != null);



  final FirebaseUser currentUser = await _auth.currentUser();

  assert(user.uid == currentUser.uid);



  return 'signInWithGoogle succeeded: $user';

}



void signOutGoogle() async{

  await googleSignIn.signOut(); 
  print("User Sign Out");

} 
  Future<bool> googleSignout() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await _auth.signOut();
    await googleSignIn.signOut();
    return true;
  }
Future < FirebaseUser > signIn(String email, String password) async {    
    try {    
        FirebaseUser user = (await _auth.signInWithEmailAndPassword(email: email, password: password)) as FirebaseUser;    
        assert(user != null);    
        assert(await user.getIdToken() != null);    
        final FirebaseUser currentUser = await _auth.currentUser();    
        assert(user.uid == currentUser.uid);    
        return user;    
    } catch (e) {    
        //handleError(e);    
        return null;    
    }    
}  


}
