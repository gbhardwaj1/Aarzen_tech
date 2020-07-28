import 'package:flutter/material.dart';

class ViewHelper extends StatelessWidget {
  
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(

                  padding: EdgeInsets.fromLTRB(260.0, 180.0, 0.0, 0.0),
                  child: Text(
                    ".",
                    style:TextStyle(
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                      color: Colors.cyan
                    ),
                  ),
               
             
      
    );
  }
  Widget intputTextData(BuildContext context,String msg, double v1,  double v2, double v3, double v4, double v5) {
    return Container(
 
                  
                  padding:   EdgeInsets. fromLTRB(v1, v2, v3, v4),
                  child: Text(
                    msg,
                    style:TextStyle(
                      fontSize: v5,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
               
             
      
    );

    

  }

  InputDecoration inputDecoration(String lableText){
      var lableText2 = lableText;
      return InputDecoration(
                    labelText: lableText2,
                    labelStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color:Colors.cyan)
                    ),
                  );
    }


}