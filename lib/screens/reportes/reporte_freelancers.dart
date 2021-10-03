import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freelancers/db/freelancer.dart';
import 'package:freelancers/models/Freelancer.dart';
import 'package:freelancers/screens/reportes/plantilla_reporte.dart';
import 'package:freelancers/util/appBarFreelancer.dart';
import 'package:freelancers/util/navegacion.dart';
import 'package:freelancers/util/freelancer_drawer.dart';


class ReporteFreelancers extends StatefulWidget {
  
  @override
 _ReporteFreelancersState createState() => _ReporteFreelancersState();

}

class _ReporteFreelancersState extends State<ReporteFreelancers>{
  

  FreelancerService freelancerService = FreelancerService();
  List<DocumentSnapshot> dataArray = <DocumentSnapshot>[];
  List<Freelancer> fList= [];
  bool finish=false;
  String carro=" ";
  @override
  void initState() {
   
     getCallsByRange();
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
    appBar: AppBarFreelancer(titulo: "Freelancers"),
    drawer: FreelancerDrawer(), 
    //body: Visibility(child: changeScreen(context, PlantillaReporte("Reporte LLamadas",columns,rows)
    
    );
  }


  getCallsByRange() async{
    List<Freelancer> freelancerList1 = await freelancerService.getFreelancers();
   
    setState(() {
      
 

      this.fList=freelancerList1;
      List<DataColumn> columns = this.getEncabezado(); 
      List<DataRow> rows = this.getRows(this.fList);
     if(rows!=null && columns!=null) {
        
     changeScreen(context, PlantillaReporte("Freelancers",columns,rows));
     }
      

    });
  }

List<DataColumn> getEncabezado() {
  List<String>  encabezado = ["Nombre","Telefono","Profesion"]; 
  List<DataColumn> headers=[];
  for(int i=0;i<encabezado.length;i++) {
    DataColumn dataColumn =  DataColumn(label: Text(encabezado[i]));
    headers.add(dataColumn);
  }
return headers;
}

List<DataRow> getRows(List<Freelancer> filas) {
  List<DataRow> rows=[];
  for(Freelancer item in filas) {
    DataRow row = DataRow(cells: [
         DataCell(Text(item.nombre)),
         DataCell(Text(item.telefono)), 
         DataCell(Text(item.profesion))
    ] );   
    rows.add(row); 
  }
  return rows;
}


}
