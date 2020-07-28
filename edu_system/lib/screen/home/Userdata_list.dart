import 'package:edu_system/models/user.dart';
import 'package:edu_system/util/view_helper.dart';
import 'package:flutter/material.dart';

class UserDataList extends StatelessWidget {
  final UserInfoData userInfoData;
//final UserProfile  userProfile;

  final ViewHelper valHelper = ViewHelper();
  UserDataList({this.userInfoData});
  // UserDataList({this.userProfile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 9.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                valHelper.intputTextData(
                    context,"Name :"+ userInfoData.fullName , 15.0, 80.0, 0.0, 0.0, 10),
                valHelper.intputTextData(
                    context, userInfoData.city, 15.0, 120.0, 0.0, 0.0, 10),
                valHelper.intputTextData(
                    context, userInfoData.state, 15.0, 140.0, 0.0, 0.0, 10),
                valHelper.intputTextData(context, userInfoData.phonenumber,
                    15.0, 160.0, 0.0, 0.0, 10),
                valHelper.intputTextData(
                    context, userInfoData.address, 15.0, 180.0, 0.0, 0.0, 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
