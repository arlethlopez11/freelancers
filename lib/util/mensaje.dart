import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freelancers/screens/home.dart';
import 'package:freelancers/screens/freelancer/freelancer_page.dart';


class Mensaje extends StatefulWidget {
  String msg;
  String boton;
 


  Mensaje(String msg, String boton) {
     this.msg=msg;
    this.boton=boton;
  }
  @override 
  _MensajeState createState() => _MensajeState(msg,boton);
}

class _MensajeState extends State<Mensaje> {
String msg;
String boton;

  _MensajeState(String msg, String boton) {
     this.msg=msg;
    this.boton= boton;
  

  }
 

void initState() {
  super.initState();

}



 @override 
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 3;
      return WillPopScope(
    onWillPop: () async => false,
              child: Scaffold(
         body: Center(
           child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
             
             children: <Widget>[
        
        Image(
                  image: AssetImage('images/background.jpg'),
                  width: 150,
                  height: 250,
                  alignment: Alignment.center,
             ),
                      
     
               Center(
                 child: Padding(
                    padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                   child: Text(msg, style: TextStyle(color: Colors.black,
                                  fontWeight: FontWeight.bold,fontSize: 25.0),),
                 ),
                 
               ),
               Center(child: Padding(
                              padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                              child: Material(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.green.withOpacity(0.8),
                              elevation: 0.0,
                              child: MaterialButton(onPressed: () async {
                            
                                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FreelancerPage()));
                              
                               
                              },
                              minWidth: MediaQuery.of(context).size.width,
                              child: Text(boton,textAlign: TextAlign.center,style: TextStyle(color: Colors.white,
                              fontWeight: FontWeight.bold,fontSize: 22.0),)
                              ),
                       ),
                            ),)        


                                         ],
                                       ),
         ), 
                              
                                    ),
      );
                              }


                            
                              
}