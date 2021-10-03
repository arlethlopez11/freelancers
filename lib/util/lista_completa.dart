
import 'package:flutter/material.dart';
import 'package:freelancers/screens/freelancer/profile.dart';
import 'package:freelancers/models/Freelancer.dart';
import 'package:freelancers/util/navegacion.dart';
class ListaCompleta extends StatefulWidget {
  
  List<Freelancer> lista;
  ListaCompleta(List<Freelancer> lista ) {
    this.lista=lista;
  }

  @override 
  _ListaCompletaState createState() => _ListaCompletaState(this.lista);

}

class _ListaCompletaState extends State<ListaCompleta> {
  List<Freelancer> lista;
  _ListaCompletaState(List<Freelancer> lista) {
     this.lista=lista;   
  }

  
  @override  
Widget build(BuildContext context)  {
    
    
    return ListView.builder(
      itemCount: lista.length,
      itemBuilder:  (context,index) {
      return  SingleFreelancer(
           freelancer: lista[index],
      );
    },
   );
    
  }



}

class SingleFreelancer extends StatelessWidget {
  final Freelancer freelancer;
  

 

    SingleFreelancer({
      this.freelancer
      
    });

  @override 
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: ()=> {
          changeScreen(context, 
                  new Profile(
                    idFreelancer: this.freelancer.id,
          nombre: this.freelancer.nombre,
              profesion: this.freelancer.profesion,
              descripcion: this.freelancer.descripcion,
              imagen: this.freelancer.foto,
              imagen2: this.freelancer.foto2,
              telefono: this.freelancer.telefono,
              categoriaId: this.freelancer.categoriaId,
              categoria: this.freelancer.categoria,
              correo: this.freelancer.correo)
                  )},
        
        //LEADING SECTION
      leading: new Image.network(freelancer.foto,width: 80.0,height: 90.0,cacheWidth: 80, cacheHeight: 90, ),  
      /*CachedNetworkImage(
            placeholder: (context, url) => CircularProgressIndicator(),
            imageUrl:
                freelancer.foto,
            width: 80,
            height: 80,    
          ), */
       //TITLE SECTION
        title: new Text(freelancer.nombre),
        //SUBTITLE SECTION
        subtitle: Row(
          children: <Widget>[

            Column(
              children: <Widget>[
                Text("Profesión ${freelancer.profesion} "),
                Text("${freelancer.correo} ${freelancer.categoria}"),
                  

              ],
            ),
               
          ],
        ),
        
        )
    );
  }


  
}
