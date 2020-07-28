

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_system/models/user.dart'; 

class DatabaseService{
final String uid;
DatabaseService({this.uid});
 
final CollectionReference userinfoCollection = Firestore.instance.collection("userinfodata");
  
Future updateUserInfo( String fullName, String city,
 String state, String phonenumber ,  String address, String uri) async{ 
   return await userinfoCollection.document(uid).setData({
     'fullName': fullName, 
     'city': city, 
     'state': state, 
     'phonenumber': phonenumber ,  
     'address': address,
     'uri': uri
   });
} 

List  <UserInfoData> _userInfoFromSnapShot(QuerySnapshot snapshot){  
   
  return snapshot.documents.map((doc)  {
      return UserInfoData (  
      fullName : doc.data['fullName'], 
      city :  doc.data['city'], 
      state :  doc.data['state'], 
      phonenumber :  doc.data['phonenumber'],  
      address :  doc.data['address'],
      uri: doc.data['uri'] );
   } ).toList();  
  }
 

Stream <List  <UserInfoData> > get userData { 
  return userinfoCollection.snapshots().map(_userInfoFromSnapShot)  ;  
}


 Stream<UserProfile> get userProfileData{ 
    return   userinfoCollection.document(uid).snapshots().map(_userProfileFromSnapshot); 
 }

// userProfile data from snapshot 
 UserProfile _userProfileFromSnapshot(DocumentSnapshot snapshot){
   
return UserProfile(
      uid: uid,
      fullName : snapshot.data['fullName'], 
      city :  snapshot.data['city'], 
      state :  snapshot.data['state'], 
      phonenumber :  snapshot.data['phonenumber'],  
      address :  snapshot.data['address'],
      uri :  snapshot.data['uri']   
  
);
}

}