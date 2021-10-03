import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
class CategoriaService {
 

   Firestore _firestore = Firestore.instance;
  String ref = 'categoria';

void createCategoria({String nombre
   }){
    var id = Uuid();
    String idCategoria = id.v1();
    
    _firestore.collection(ref).document(idCategoria).setData({
              'id': idCategoria,            
              'nombre' : nombre,

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