import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freelancers/db/llamada.dart';
import 'package:freelancers/models/SeanLLamada.dart';
import 'package:freelancers/util/appBarFreelancer.dart';
import 'package:freelancers/util/freelancer_drawer.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class PlantillaReporte extends StatefulWidget {
String titulo;  
List<DataColumn> listaEncabezado;
List<DataRow> lista;

PlantillaReporte(String titulo,List<DataColumn>listaEncabezado,List<DataRow>lista) {
  this.titulo=titulo;
  this.listaEncabezado=listaEncabezado;
  this.lista=lista;
}

  @override
 _PlantillaReporteState createState() => _PlantillaReporteState(this.titulo, this.listaEncabezado, this.lista);

}

class _PlantillaReporteState extends State<PlantillaReporte>{
  List<DataColumn> listaEncabezado;
  List<DataRow> lista;
  String titulo;
  _ResultDataSource resultDataSource= _ResultDataSource();
_PlantillaReporteState(String titulo,List<DataColumn>listaEncabezado,List<DataRow> lista) {
  this.listaEncabezado=listaEncabezado;
  this.lista=lista;
  this.titulo=titulo;
}

@override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
    appBar: AppBarFreelancer(titulo: titulo),
    drawer: FreelancerDrawer(), 

    body: Scrollbar(
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(columns: listaEncabezado, rows: lista),
          
          ),
      //    PaginatedDataTable(header: Text("Resultados "), columns: this.listaEncabezado, source: this.resultDataSource),
         
      ],)
      

           
            
    ),
   /* body:    Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            Expanded(
              child:   SingleChildScrollView(
         scrollDirection: Axis.vertical,
         child: DataTable(columns: listaEncabezado, rows: lista),
         ),
            ),]),
     */  

    );
  }


}



  class _ResultDataSource extends DataTableSource {
final List<DataRow> rows;
 _ResultDataSource({this.rows});

  @override
  DataRow getRow(int index) {
    // TODO: implement getRow
    return this.rows[index];
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => this.rows.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => this.rows.length;
    
  }