import 'package:flutter/material.dart';
import 'package:freelancers/screens/home.dart';
import 'package:freelancers/screens/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
      title: 'Freelancers',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home: Login(),
    );
  }
}




