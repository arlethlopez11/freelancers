import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:freelancers/db/freelancer.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:freelancers/models/Freelancer.dart';
import 'package:freelancers/screens/login.dart';
import 'package:freelancers/util/appBarFreelancer.dart';
import 'package:freelancers/util/navegacion.dart';
import 'package:freelancers/util/freelancer_drawer.dart';
import 'package:freelancers/util/globals.dart' as globals;

class ModificarFreelancer extends StatefulWidget {
  String idFreelancer;
  ModificarFreelancer(String idFreelancer){
      this.idFreelancer=idFreelancer;
  }
  @override
  _ModificarFreelancerState createState() => _ModificarFreelancerState(this.idFreelancer);
}

class _ModificarFreelancerState extends State<ModificarFreelancer> {
String idFreelancer;
_ModificarFreelancerState(idFreelancer) {
this.idFreelancer=idFreelancer;
}

  FreelancerService freelancerService = FreelancerService(); 
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nombreController = TextEditingController();
  TextEditingController profesionController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  TextEditingController correoController = TextEditingController();
  
  
  
  List<Freelancer> pilotoList=[];
  List<DocumentSnapshot> dataArray = <DocumentSnapshot>[];
  List<DocumentSnapshot> dataArrayTwo = <DocumentSnapshot>[];
  
  Color white = Colors.white;
  Color black = Colors.black;
  Color grey = Colors.grey;
  Color red = Colors.red;
  List<String> selectedSizes = <String>[];
  File _image1;
  File _image2;
  bool isLoading=false;
  String pathImage=" ";
  String pathImage2=" ";
  String imagen1=" ";
  String imagen2=" ";
  bool finish=false;
  bool isPickedImage=false;
  bool isPickedImage2=false;
  String correo=" ";
  String categoria= " ";
  int categoriaId= 0;
  int _value=0;






  @override
  void initState() {
    getFreelancer(idFreelancer);
   
  }


  

  
  getFreelancer(String id)  {
    FreelancerService freelancer =  FreelancerService();
     Freelancer d =  freelancer.getRam(id);
     
      

      nombreController.text= d.nombre;
      profesionController.text= d.profesion;
      descripcionController.text= d.descripcion;
      correoController.text = d.correo;
      categoria = d.categoria;
      categoriaId = d.categoriaId;
  this.pathImage = d.foto;
       this.pathImage2 = d.foto2;
      telefonoController.text = d.telefono;
     
      this.correo= d.correo;
}


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarFreelancer(titulo: "Modificar Freelancer"),
      drawer: FreelancerDrawer(),
      body: Visibility(
              visible: finish,
              child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: isLoading ? CircularProgressIndicator() : Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OutlineButton(
                          borderSide: BorderSide(color: grey.withOpacity(0.5), width: 2.5),
                          onPressed: (){
                            _selectImage(ImagePicker.pickImage(source: ImageSource.gallery), 1);
                          },
                          child: _displayChild1()
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OutlineButton(
                          borderSide: BorderSide(color: grey.withOpacity(0.5), width: 2.5),
                          onPressed: (){
                            _selectImage2(ImagePicker.pickImage(source: ImageSource.gallery), 1);
                          },
                          child: _displayChild2()
                        ),
                      ),
                    ),

                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('ingresa el nombre del freelancer',textAlign: TextAlign.center ,style: TextStyle(color: red, fontSize: 12),),
                ),

                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: nombreController,
                    decoration: InputDecoration(
                      hintText: 'nombre freelancer',
                      icon: Icon(Icons.account_box)
                    ),
                    validator: (value){
                      if(value.isEmpty){
                        return 'debes ingresar el nombre del freelancer';
                      }
                    },
                  ),
                ),

//              select category
                

//
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: telefonoController,
                  
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                       icon: Icon(Icons.phone),
                        hintText: 'Telefono',
                    ),
                    validator: (value){
                      if(value.isEmpty){
                        return 'Debes ingresar el numero de Telefono';
                      }
                    },
                  ),
                ),
 Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: DropdownButton(
            value: _value,
            items: [
              DropdownMenuItem(
                  child: Text("Programador"),
                  value: 1,
              ),
              DropdownMenuItem(
                  child: Text("Diseño Grafico"),
                  value: 2,
              ),
              DropdownMenuItem(
                  child: Text("Abogado"),
                  value: 3,
              ),
              DropdownMenuItem(
                  child: Text("Doctor"),
                  value: 4,
              ),
              DropdownMenuItem(
                  child: Text("Enfermeria"),
                  value: 5,
              )
            
            ],
               onChanged: (value) {
                setState(() {
                  _value = value;
                });
              },
         
            hint:Text("Selecciona categoria")
            ),
               ),

                 Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: profesionController,
                  
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                       icon: Icon(Icons.perm_identity),
                        hintText: 'Profesión u ocupación',
                    ),
                    validator: (value){
                      if(value.isEmpty){
                        return 'Debes ingresar la profesión';
                      }
                    },
                  ),
                ),
                   Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: correoController,
                  
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                       icon: Icon(Icons.email),
                        hintText: 'Correo electronico',
                    ),
                    validator: (value){
                      if(value.isEmpty){
                        return 'Debes ingresar el correo electronico';
                      }
                    },
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: descripcionController,
                  
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                       icon: Icon(Icons.note),
                        hintText: 'Descripción',
                    ),
                    validator: (value){
                      if(value.isEmpty){
                        return 'Debes ingresar descripción';
                      }
                    },
                  ),
                ),


                FlatButton(
                  color: red,
                  textColor: white,
                  child: Text('Modificar Freelancer'),
                  onPressed: (){
                    validateAndUpload();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

   

  

  
  void _selectImage(Future<File> pickImage, int imageNumber) async{
    File tempImg = await pickImage;
    switch(imageNumber){
      case 1: { setState(() => _image1 = tempImg);
        this.isPickedImage=true;
      }
      break;
     
    }
  }

  void _selectImage2(Future<File> pickImage, int imageNumber) async{
    File tempImg = await pickImage;
    switch(imageNumber){
      case 1: { setState(() => _image2 = tempImg);
        this.isPickedImage2=true;
      }
      break;
     
    }
  }

 Widget _displayChild1() {
    if(this.pathImage == null){
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
        child: new Icon(Icons.add, color: grey,),
      );
    }else if(isPickedImage){
      return Image.file(_image1, fit: BoxFit.fill, width: double.infinity,);
     
    }
    else if(isPickedImage==false) {
       return Image.network(pathImage, width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.25,);
    /*  return      CachedNetworkImage(
            placeholder: (context, url) => CircularProgressIndicator(),
            imageUrl:
                pathImage,
            width:  MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.25,   
          ); */
    }
 }

Widget _displayChild2() {
    if(this.pathImage2 == null){
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
        child: new Icon(Icons.add, color: grey,),
      );
    }else if(isPickedImage2){
      return Image.file(_image2, fit: BoxFit.fill, width: double.infinity,);
     
    }
    else if(isPickedImage2==false) {
           return Image.network(pathImage2, width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.25,);
  
       //return Image.network(pathImage2,fit: BoxFit.fill, width: double.infinity,);
    /*  return      CachedNetworkImage(
            placeholder: (context, url) => CircularProgressIndicator(),
            imageUrl:
                pathImage2,
            width:  MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.25,   
          ); */
    }
 }


  void validateAndUpload() async {
    if(_formKey.currentState.validate()){
        setState(() => isLoading= true);

        if(isPickedImage==true && isPickedImage2==true) {
            
            String imageUrl;
            final FirebaseStorage storage = FirebaseStorage.instance;
            final String picture1 = "${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
          StorageUploadTask task = storage.ref().child(picture1).putFile(_image1);

           task.onComplete.then((snapshot) async{
            imageUrl = await snapshot.ref.getDownloadURL();  
           this.imagen1 = imageUrl;
            

            String imageUrl2;
            final String picture2 ="${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";  
            StorageUploadTask task2 = storage.ref().child(picture2).putFile(_image2);
            task2.onComplete.then((snapshot2) async {
              imageUrl2= await snapshot2.ref.getDownloadURL();
              this.imagen2=imageUrl2;

              this.seanUpdate(this.imagen1, this.imagen2);
            });                       
                                
          } );
        }
        else if(isPickedImage==true && isPickedImage2==false) {
             String imageUrl;
            final FirebaseStorage storage = FirebaseStorage.instance;
            final String picture1 = "${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
          StorageUploadTask task = storage.ref().child(picture1).putFile(_image1);

           task.onComplete.then((snapshot) async{
            imageUrl = await snapshot.ref.getDownloadURL();  
           this.imagen1 = imageUrl;
           this.imagen2 = this.pathImage2;
           
                   this.seanUpdate(this.imagen1, this.imagen2);                  


           });
        }
        else if(isPickedImage==false && isPickedImage2==true) {
             String imageUrl;
            final FirebaseStorage storage = FirebaseStorage.instance;
            final String picture1 = "${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
          StorageUploadTask task = storage.ref().child(picture1).putFile(_image2);

           task.onComplete.then((snapshot) async{
            imageUrl = await snapshot.ref.getDownloadURL();  
           this.imagen2 = imageUrl;
           this.imagen1 = this.pathImage;
           
                   this.seanUpdate(this.imagen1, this.imagen2);                  


           });
        }
        else if(isPickedImage==false && isPickedImage2==false) {
            this.imagen2 = this.pathImage2;
           this.imagen1 = this.pathImage;
           
                   this.seanUpdate(this.imagen1, this.imagen2);   
            
        }

        

    }
  }

  seanUpdate(String sImage1, String sImage2) {
    freelancerService.update(
             freelancerId: this.idFreelancer, 
             nombre: this.nombreController.text,
             profesion: this.profesionController.text, 
             descripcion: this.descripcionController.text,
             foto: sImage1,
             foto2: sImage2,
             telefono: this.telefonoController.text,
             correo: this.correo,
             categoria: this.categoria,
             categoriaId: this.categoriaId
            );
          setState(()=>isLoading=false);
            seanToastGreen("Cambios Guardados exitosamente");
            changeScreen(context,Login());
  }



}
