import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freelancers/models/SeanLLamada.dart';
import 'package:uuid/uuid.dart';
class WhatsService {
 

   Firestore _firestore = Firestore.instance;
  String ref = 'whatsup';

void createWhatsup({String cliente, String telefonoCliente,String telefonoFreelancer, String nombreFreelancer

   }){
    var now = new DateTime.now(); 
    var id = Uuid();
    String llamadaId = id.v1();
    
    _firestore.collection(ref).document(llamadaId).setData({
              'id': llamadaId,            
              'cliente' : cliente,
              'telefonoCliente' : telefonoCliente,
              'telefonoFreelancer' : telefonoFreelancer,
              'freelancer' : nombreFreelancer,
              'fecha': now,

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

Future<List<DocumentSnapshot>> getByDate(Timestamp fechaIni) =>
      _firestore.collection(ref).where('fecha', isGreaterThanOrEqualTo: fechaIni).orderBy('fecha',descending: true).limit(30).getDocuments().then((snap){
    List<DocumentSnapshot> subLista=<DocumentSnapshot>[];  
    /* snap.documents.forEach((f){
       Timestamp t = f.data['fecha'];
        
           if(t.toDate().millisecondsSinceEpoch <= fechaFin.toDate().millisecondsSinceEpoch) {
              subLista.add(f);
           } 
     }); 
     */
     return snap.documents;
      });

getCallsByRange(DateTime fechaIni, DateTime fechaFin) async{
   List<DocumentSnapshot> dataArray;
    Timestamp to = Timestamp.fromMillisecondsSinceEpoch(fechaIni.toUtc().millisecondsSinceEpoch);
    Timestamp tf = Timestamp.fromMillisecondsSinceEpoch(fechaFin.toUtc().millisecondsSinceEpoch);
    List<DocumentSnapshot> data = await getByDate(to);
    print(data.length);
    
      dataArray = data;
      String current="";
   
       List<SeanLLamada> llamadaList1 =  [];
 
      for(var i=0;i<dataArray.length;i++) {
        Timestamp fechaT =dataArray[i].data['fecha'];

      if(fechaT.millisecondsSinceEpoch <= tf.millisecondsSinceEpoch) {
          DateTime fechaDT = fechaT.toDate();
        print(fechaDT);
      SeanLLamada llamada = new SeanLLamada(
         id: dataArray[i].data['id'], 
         cliente: dataArray[i].data['cliente'],
         telefonoCliente: dataArray[i].data['telefonoCliente'], 
         freelancer: dataArray[i].data['freelancer'],
         telefonoFreelancer: dataArray[i].data['telefonoFreelancer'],
         fecha: fechaDT
      );
             
       llamadaList1.add(llamada); 

      }
        

      }

     return llamadaList1;

    
  }


}