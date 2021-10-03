import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:freelancers/db/freelancer.dart';
import 'package:freelancers/models/Freelancer.dart';
import 'package:freelancers/screens/freelancer/add_freelancer.dart';
import 'package:freelancers/util/appBarFreelancer.dart';
import 'package:freelancers/util/component.dart';
import 'package:freelancers/util/lista_completa.dart';
import 'package:freelancers/util/mensaje.dart';
import 'package:freelancers/util/navegacion.dart';
import 'package:freelancers/util/freelancer_drawer.dart';
import 'package:freelancers/util/globals.dart' as globals;

class FreelancerPage extends StatefulWidget {
  
  @override
 _FreelancerPageState createState() => _FreelancerPageState();

}

class _FreelancerPageState extends State<FreelancerPage>{
  

  FreelancerService freelancerService = FreelancerService();
  List<DocumentSnapshot> dataArray = <DocumentSnapshot>[];
  List<Freelancer> freelancerList= [];
  List<Freelancer> listaFreelancers =[];
  List<Component> lista=[];
  String carro=" ";
  bool finish=false;
  @override
  void initState() {
    //this.getAllCars();
    //this.getAll();
    this.listaFreelancers=globals.listaFreelancers;
    if(this.listaFreelancers!=null) {
      if(this.listaFreelancers.length==0) {
         
     
        changeScreenReplacemente(context, AddFreelancer());
      }
      else if(this.listaFreelancers.length>0) {
        setState(() {
          finish=true;
        });
      }
    }
   

    
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
    appBar: AppBarFreelancer(titulo: "Freelancers"),
    drawer: FreelancerDrawer(), 
    body: Visibility(
      visible: finish,
      child: ListaCompleta(listaFreelancers)),
    );
  }


  getAll() async{
      this.freelancerList = await freelancerService.getFreelancers();
  
  }


@override
  void dispose() {
    // TODO: implement dispose
    this.freelancerList=null;
    this.freelancerService=null;
    
  }
}
