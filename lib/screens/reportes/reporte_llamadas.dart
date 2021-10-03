import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freelancers/db/llamada.dart';
import 'package:freelancers/models/SeanLLamada.dart';
import 'package:freelancers/screens/reportes/plantilla_reporte.dart';
import 'package:freelancers/util/appBarFreelancer.dart';
import 'package:freelancers/util/navegacion.dart';
import 'package:freelancers/util/freelancer_drawer.dart';


class ReporteLlamadas extends StatefulWidget {
  
  @override
 _ReporteLlamadasState createState() => _ReporteLlamadasState();

}

class _ReporteLlamadasState extends State<ReporteLlamadas>{
  

  LlamadaService llamadaService = LlamadaService();
  List<DocumentSnapshot> dataArray = <DocumentSnapshot>[];
  List<SeanLLamada> llamadaList= [];
  DateTime fechaIni;
  DateTime fechaFin;
  String carro=" ";
  @override
  void initState() {
   
    
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
    appBar: AppBarFreelancer(titulo: "Freelancers"),
    drawer: FreelancerDrawer(), 
    body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(fechaIni == null ? 'No has seleccionado esta fecha aun' : DateToString(fechaIni),
            style: TextStyle(fontSize: 16.0, color: Colors.black),
            ),
            RaisedButton(
              child: Text('Fecha Inicial'),
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: fechaIni == null ? DateTime.now() : fechaIni,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030)
                ).then((date) {
                  setState(() {
                    fechaIni = date;
                  });
                });
              },
            ),
            Text(fechaFin == null ? 'No has seleccionado esta fecha aun' : DateToString(fechaFin),
            style: TextStyle(fontSize: 16.0, color: Colors.black),
            ),
            RaisedButton(
              child: Text('Fecha Final'),
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: fechaFin == null ? DateTime.now() : fechaFin,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030)
                ).then((date) {
                  setState(() {
                    fechaFin = date;
                    this.getCallsByRange(fechaIni, fechaFin);
                    


                  });
                });
              },
            )
          ],
        ),
      ),
    );
  }


  getCallsByRange(DateTime fechaIni, DateTime fechaFin) async{
      this.llamadaList =  await llamadaService.getCallsByRange(fechaIni, fechaFin);
      List<DataColumn> columns = this.getEncabezado(); 
      List<DataRow> rows = this.getRows(this.llamadaList);
      changeScreen(context, PlantillaReporte("Reporte LLamadas",columns,rows));
      
  }

List<DataColumn> getEncabezado() {
  List<String>  encabezado = ["Fecha","Freelancer","# Cliente","Cliente"]; 
  List<DataColumn> headers=[];
  for(int i=0;i<encabezado.length;i++) {
    DataColumn dataColumn =  DataColumn(label: Text(encabezado[i],style: TextStyle(fontSize: 11.0),));
    headers.add(dataColumn);
  }
return headers;
}

List<DataRow> getRows(List<SeanLLamada> filas) {
  List<DataRow> rows=[];
  for(SeanLLamada item in filas) {
    DataRow row = DataRow(cells: [
         DataCell(Text(DateToString(item.fecha),style: TextStyle(fontSize: 11.0),)),
         DataCell(Text(item.freelancer,style: TextStyle(fontSize: 11.0),)),
       //  DataCell(Text(item.telefonoFreelancer,style: TextStyle(fontSize: 11.0),)),
     //    DataCell(Text(item.cliente,style: TextStyle(fontSize: 11.0),)),
         DataCell(Text(item.telefonoCliente,style: TextStyle(fontSize: 11.0),)),
         DataCell(Text(item.cliente,style: TextStyle(fontSize: 11.0),)),
         
          
    ] );   
    rows.add(row); 
  }
  return rows;
}


}
