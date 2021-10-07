import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freelancers/util/freelancer_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:freelancers/db/llamada.dart';
import 'package:freelancers/db/freelancer.dart';
import 'package:freelancers/screens/home.dart';
import 'package:freelancers/screens/freelancer/modificar_freelancer.dart';
import 'package:freelancers/screens/freelancer/freelancer_page.dart';
import 'package:freelancers/util/appBarFreelancer.dart';
import 'package:freelancers/util/navegacion.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:freelancers/app_icons.dart' as AppIcon;

class Profile extends StatefulWidget {
final idFreelancer;  
final nombre;
final profesion;
final descripcion;
final categoriaId;
final imagen;
final imagen2;
final telefono;
final categoria;
final correo;


Profile({
  this.idFreelancer,
  this.nombre,
  this.profesion,
  this.descripcion,
  this.imagen,
  this.imagen2,
  this.telefono,
  this.categoriaId,
  this.correo,
  this.categoria
});

  @override 
  _ProfileState createState()=> _ProfileState();

}

class _ProfileState extends State<Profile> {

  TextEditingController quatityController = TextEditingController();
  int _currentValue=1;
  LlamadaService llamadaService = LlamadaService();
  FreelancerService freelancerService = FreelancerService();

  @override  
  Widget build(BuildContext context) {
    return Scaffold(  
        
        appBar: AppBarFreelancer(titulo: "Información Freelancer",),
        drawer: FreelancerDrawer(),
    body: new ListView(   
      children: <Widget>[
Row(children: <Widget>[
            Text("Freelancer: ${widget.nombre}", style: TextStyle(color: Colors.black, fontSize: 22.0)),
          ],
          ),
          
       Image.network(widget.imagen,width:  MediaQuery.of(context).size.width,height:  MediaQuery.of(context).size.height*0.25,),
       /* CachedNetworkImage(
            placeholder: (context, url) => CircularProgressIndicator(),
            imageUrl:
                widget.imagen,
            width:  MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.25,   
          ),  */
   
            Divider(),
             Row(children: <Widget>[
            Text(" ${widget.profesion} ", style: TextStyle(color: Colors.black, fontSize: 18.0)),
          ],
          ),
            Row(children: <Widget>[
            Text(" ${widget.correo}", style: TextStyle(color: Colors.black, fontSize: 18.0)),
          ],
          ),
           /* CachedNetworkImage(
            placeholder: (context, url) => CircularProgressIndicator(),
            imageUrl:
                widget.imagenCarro,
            width:  MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.25,   
          ), */
   
            Divider(),
             Row(children: <Widget>[
            Text(" ${widget.descripcion}", style: TextStyle(color: Colors.black, fontSize: 15.0)),
          ],
          ),
        
       Image.network(widget.imagen2,width:  MediaQuery.of(context).size.width,height:  MediaQuery.of(context).size.height*0.25,),   
       /*     CachedNetworkImage(
            placeholder: (context, url) => CircularProgressIndicator(),
            imageUrl:
                widget.imagen2,
            width:  MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.25,   
          ),    */          
          
          Divider(),
         
          Row(children: <Widget>[
            Text("Categoria: ${widget.categoria}", style: TextStyle(color: Colors.black, fontSize: 18.0)),
          ],
          ),
       
        /*  CachedNetworkImage(
            placeholder: (context, url) => CircularProgressIndicator(),
            imageUrl:
                widget.imagenCarro2,
            width:  MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.25,   
          ),  */
          Divider(),
           Row(  
             children: <Widget>[
              Expanded(  
                  child: MaterialButton(onPressed: () {
                    String phone;
                    String usuario;
                    SharedPreferences.getInstance().then((preferences){
                    phone=preferences.getString('phone');
                    usuario=preferences.getString('usuario');
                    llamadaService.createLLamada(
                        cliente: usuario,
                        telefonoCliente: phone,
                        nombreFreelancer: widget.nombre,
                        telefonoFreelancer: widget.telefono
                    );

                    launch("tel://${widget.telefono}");

                    });
                  
                  }, 
                  color: Colors.green,
                  textColor: Colors.white,
                  elevation: 0.2,
                  
                  // primeros botones
                  child: new Text("Llamar", style: TextStyle(fontSize: 25.0))
                  ),
                ),  
              
                
             ],
           ),
          /*
           Row(  
             children: <Widget>[
              Expanded(  
                  child: MaterialButton(onPressed: () {
                    changeScreen(context, ModificarFreelancer(widget.idFreelancer));
                    
                  // ModificarFreelance(widget.idFreelancer)
                  }, 
                  color: Colors.blue,
                  textColor: Colors.white,
                  elevation: 0.2,
                  
                  // primeros botones
                  child: new Text("Modificar", style: TextStyle(fontSize: 25.0))
                  ),
                ),  
               
                
             ],
           ),
           
           Row(  
             children: <Widget>[
              Expanded(  
                  child: MaterialButton(onPressed: () {
                    confirmDelete(widget.idFreelancer);
                  }, 
                  color: Colors.red,
                  textColor: Colors.white,
                  elevation: 0.2,
                  
                  // primeros botones
                  child: new Text("Eliminar", style: TextStyle(fontSize: 25.0))
                  ),
                ),  
              
                
             ],
           ),
          */
          /*
             FloatingActionButton(    
        backgroundColor: Colors.green,       
        child: Icon(
          AppIcon.AppIcons.whatsapp
        ),
        onPressed: () async {
           String phone;
                    String usuario;
                  SharedPreferences preferences = await SharedPreferences.getInstance();
                    phone=preferences.getString('phone');
                    usuario=preferences.getString('usuario');
                    llamadaService.createWhatsup(
                        cliente: usuario,
                        telefonoCliente: phone,
                        nombreFreelancer: widget.nombre,
                        telefonoFreelancer: widget.telefono
                    );

                   whatsAppOpen(); 

        },
        heroTag: null,
      )
      */
      ],
    ),

    );
  }

void confirmDelete(String id){
 var alert = new AlertDialog(
   backgroundColor: Colors.white,
    title: new Text("Eliminar", style: TextStyle(color: Colors.black),),
    content: new Text("¿Estas seguro de eliminar el registro de este freelancer?",
    style: TextStyle(color: Colors.black, backgroundColor: Colors.white, fontSize: 14.0)),
      actions: <Widget>[
        Container(
          alignment: Alignment.center,
          child: new FlatButton(
            
            color: Colors.red,
            child: new Text("Si, Eliminar",style: TextStyle(color: Colors.white ), textAlign:TextAlign.center,),
            onPressed: () async {
                  freelancerService.delete(freelancerId: id);
                  seanToastGreen("Registro eliminado");
                  changeScreen(context, FreelancerPage());
            },
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: new FlatButton(
            
            color: Colors.green,
            child: new Text("Regresar",style: TextStyle(color: Colors.white ), textAlign:TextAlign.center,),
            onPressed: () async {
              
               Navigator.of(context).pop();
            },
          ),
        )
      ],
    );  

 showDialog(context: context, builder: (_) => alert);
}
  
/*
void whatsAppOpen() async {
    bool whatsapp = await FlutterLaunch.hasApp(name: "whatsapp");

    if (whatsapp) {
      await FlutterLaunch.launchWathsApp(phone: "+502"+"${widget.telefono}", message: "Hola!, esta disponible para un trabajo de ..?");
    } else {
      print("Whatsapp no instalado");
    }
  }
*/

}