
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelancers/screens/freelancer/add_freelancer.dart';
import 'package:freelancers/screens/freelancer/freelancer_page.dart';
import 'package:freelancers/screens/reportes/reporte_llamadas.dart';
import 'package:freelancers/screens/reportes/reporte_whats.dart';
import 'package:freelancers/util/navegacion.dart';


class FreelancerDrawer extends StatefulWidget {

 @override
 _FreelancerDrawerState createState() => _FreelancerDrawerState();
}


class _FreelancerDrawerState extends State<FreelancerDrawer>{

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
 
  @override
  initState(){
  }
  
  
    @override
    Widget build(BuildContext context) {
      return Drawer(
          child: new ListView(
        children: <Widget>[
          //header dreawer
          Container(
            color: Colors.blue.shade900,
            child: new UserAccountsDrawerHeader(
              accountName: Text(" "),
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                  // backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white),
                ),
              ),
              decoration: new BoxDecoration(
                  // color: Colors.red
                  ),
            ),
          ),
          //body
        
         
          
           InkWell(   
              onTap: (){
                        changeScreen(context, AddFreelancer());
              },
               child:  ListTile(
              title: Text('Crear Freelancer'),
              leading: Icon(Icons.account_circle,color:Colors.yellow),
          )
          
          ),
            
  
           InkWell(   
            onTap: (){
                               changeScreen(context,FreelancerPage());
            },
             child:  ListTile(
            title: Text('Lista de Freelancers'),
            leading: Icon(Icons.supervisor_account,color:Colors.green[300]),
          )
          
          ),
       
           InkWell(   
            onTap: (){
                               changeScreen(context,ReporteLlamadas());
            },
             child:  ListTile(
            title: Text('Reporte de llamadas'),
            leading: Icon(Icons.phone,color:Colors.green[300]),
          )
          
          ),
          /*InkWell(   
            onTap: (){
                               changeScreen(context,ReporteWhats());
            },
             child:  ListTile(
            title: Text('Reporte Whatsapp'),
            leading: Icon(Icons.phone_android,color:Colors.green[300]),
          )
          
          ),
          */
          
          /*InkWell(   
            onTap: (){
                               changeScreen(context,Inbox());
            },
             child:  ListTile(
            title: Text('Inbox'),
            leading: Icon(Icons.email,color:Colors.green[300]),
          )
          
          ),
          */
                ],
      ));
    }
  
  
}
