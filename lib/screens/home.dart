import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freelancers/models/SeanAdmin.dart';
import 'package:freelancers/screens/freelancer/freelancer_page.dart';
class Home extends StatefulWidget {

  @override
 _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{


  //final FirebaseUser user;

 // Home({this.user});
 @override
 initState() {
  // getAdmins();
 }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      


      body: FreelancerPage(), 


    
    );
  }
}
