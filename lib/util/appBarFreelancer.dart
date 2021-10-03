import 'package:flutter/material.dart';
class AppBarFreelancer extends StatelessWidget  with PreferredSizeWidget{
  String titulo;
     AppBarFreelancer({this.titulo});
  @override
  Widget build(BuildContext context) {
    

    return PreferredSize(
          child: new AppBar(
          elevation:0.1,
           title: Text(this.titulo),
           actions: <Widget>[
             
           ],
        ),
    );
  }

  
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}