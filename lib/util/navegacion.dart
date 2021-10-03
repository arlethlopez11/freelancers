import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
Color deepOrange= Colors.deepOrange;
Color white = Colors.white;
  Color black = Colors.black;
  Color grey = Colors.grey;
  Color red = Colors.red;

void changeScreen(BuildContext context, Widget widget){
   Navigator.push(context, MaterialPageRoute(builder: (context)=>widget));
}

void changeScreenReplacemente(BuildContext context, Widget widget){
   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>widget));
}

String DateToString(DateTime now) {
  String formattedDate = DateFormat('dd-MM-yyyy – kk:mm').format(now);
  return formattedDate;
}


 Future<bool> seanToastRed(String msg) {
      return Fluttertoast.showToast(msg: msg, backgroundColor: Colors.red,
          fontSize: 22.0, textColor: Colors.white, gravity: ToastGravity.CENTER, toastLength: Toast.LENGTH_LONG );
            
      
    }

 
 Future<bool> seanToastGreen(String msg) {
      return Fluttertoast.showToast(msg: msg, backgroundColor: Colors.green,
          fontSize: 22.0, textColor: Colors.white, gravity: ToastGravity.CENTER, toastLength: Toast.LENGTH_LONG );
            
      
    }   

  seanShowDialog (BuildContext context, String errorMsg) {
    return showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Container(
                          child: Text(errorMsg),
                        ),
                      );
                    });
    
  }

  Widget crearLoadingInferior() {
  return Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.end,
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
        ],
      ),
    ],
  );
}