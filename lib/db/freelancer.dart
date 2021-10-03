
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:freelancers/models/SeanLista.dart';
import 'package:freelancers/models/Freelancer.dart';
import 'package:uuid/uuid.dart';
import 'package:freelancers/util/globals.dart' as globals;
class FreelancerService {
 

   Firestore _firestore = Firestore.instance;
  String ref = 'freelancer';

  String create({String nombre, String profesion,
  String foto,String foto2, String descripcion, String telefono, int categoriaId, String categoria,
   String correo}){
    var id = Uuid();
    String freelanceId = id.v1();
    
    _firestore.collection(ref).document(freelanceId).setData({
              'id': freelanceId,            
              'nombre' : nombre,
              'profesion' : profesion,
              'foto' : foto,
              'foto2': foto2,
              'descripcion' : descripcion,
              'telefono': telefono,
              'categoriaId': categoriaId,
              'categoria': categoria,
              'correo': correo

      });
      return freelanceId;
  }

  

 Future<void> update({String freelancerId,String nombre, String profesion,
  String foto, String foto2, String descripcion, String telefono, int categoriaId,
  String correo, String categoria
   }) async {
    _firestore.collection(ref).document(freelancerId).updateData({
              'id': freelancerId,            
              'nombre' : nombre,
              'profesion' : profesion,
              'foto' : foto,
              'foto2': foto2,
              'descripcion' : descripcion,
              'telefono': telefono,
              'categoriaId': categoriaId,
              'categoria': categoria,
              'correo': correo

      });

  

  }

   void delete({String freelancerId
   }){
   
    _firestore.collection(ref).document(freelancerId).delete();
  }

 Future<List<DocumentSnapshot>> getAll() =>
      _firestore.collection(ref).getDocuments().then((snap){
        return snap.documents;
      });


Future<List<DocumentSnapshot>> getById(String id) =>
      _firestore.collection(ref).where('id', isEqualTo: id).getDocuments().then((snap){
        return snap.documents;
      });

 Future<List<Freelancer>> getFreelancers() async {
   List<Freelancer> lista=[];
    List<DocumentSnapshot> dataArray = await getAll();
    for(DocumentSnapshot d in dataArray) {
        Freelancer freelancer = Freelancer(
              d.data['id'], 
          d.data['nombre'],
          d.data['descripcion'],
          d.data['foto'],
          d.data['foto2'],
          d.data['categoriaId'],
          d.data['categoria'],
           d.data['telefono'],
          d.data['correo'],
          d.data['profesion'] 
        );
        lista.add(freelancer);
    }
    return lista;
 }     


Future<Freelancer> get(String id) async {
   List<Freelancer> lista=[];
    List<DocumentSnapshot> dataArray = await getById(id);
    for(DocumentSnapshot d in dataArray) {
        Freelancer freelancer = Freelancer(
              d.data['id'], 
          d.data['nombre'],
          d.data['profesion'], 
          d.data['foto'],
          d.data['foto2'],
          d.data['descripcion'],
          d.data['telefono'],
          d.data['categoriaId'],
           d.data['categoria'],
          d.data['correo']
        );
        lista.add(freelancer);
    }
    return lista[0];
 } 

  Freelancer getRam(String id) {
      List<Freelancer> lista = globals.listaFreelancers;
      for(Freelancer item in lista) {
          if(item.id==id) {
            return item; 
          }
      }
      return null;
      
 }

 


}