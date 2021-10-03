import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
class Admins {
 

   Firestore _firestore = Firestore.instance;
  String ref = 'admins';

  void createCar({ 
  String nombre, String telefono
   }){
    var id = Uuid();
    String idAdmin = id.v1();
   
    _firestore.collection(ref).document(idAdmin).setData({
              'id': idAdmin,            
              'nombre': nombre,
              'telefono': telefono

      });
  }

 Future<List<DocumentSnapshot>> getAll() =>
      _firestore.collection(ref).getDocuments().then((snap){
        return snap.documents;
      });

 
  Future<List<DocumentSnapshot>> getById(String id) =>
      _firestore.collection(ref).where('id', isEqualTo: id).getDocuments().then((snap){
        return snap.documents;
      });     


    


}