import 'dart:io';


import 'package:freelancers/db/freelancer.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freelancers/screens/freelancer/freelancer_page.dart';
import 'package:freelancers/util/freelancer_drawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freelancers/screens/home.dart';
import 'package:freelancers/util/appBarFreelancer.dart';
import 'package:freelancers/util/navegacion.dart';

class AddFreelancer extends StatefulWidget {
  @override
  _AddFreelancerState createState() => _AddFreelancerState();
}

class _AddFreelancerState extends State<AddFreelancer> {
  
  FreelancerService freelancerService = FreelancerService(); 
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nombreController = TextEditingController();
  TextEditingController profesionController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  TextEditingController correoController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  

  
  List<DocumentSnapshot> vehiculos = <DocumentSnapshot>[];
  String carroId=" ";
  Color white = Colors.white;
  Color black = Colors.black;
  Color grey = Colors.grey;
  Color red = Colors.red;
  List<String> selectedSizes = <String>[];
  File _image1;
  File _image2;
  bool isLoading=false;
  int _value=1;





  @override
  void initState() {
   
   
  }



  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarFreelancer(titulo: "Agregar Freelancer"),
      drawer: FreelancerDrawer(),
      body: Form(
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
                    hintText: 'Nombre',
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
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: profesionController,
                
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                     icon: Icon(Icons.work),
                      hintText: 'Profesión u Ocupación',
                  ),
                  validator: (value){
                    if(value.isEmpty){
                      return 'Debes ingresar la profesión u ocupación';
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
                
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                     icon: Icon(Icons.note),
                      hintText: 'descripcion',
                  ),
                  validator: (value){
                    if(value.isEmpty){
                      return 'Debes ingresar la descripcion';
                    }
                  },
                ),
              ),
              FlatButton(
                color: red,
                textColor: white,
                child: Text('agregar Freelancer'),
                onPressed: (){
                  validateAndUpload();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

   

  

  
  void _selectImage(Future<File> pickImage, int imageNumber) async{
    File tempImg = await pickImage;
    switch(imageNumber){
      case 1:  setState(() => _image1 = tempImg);
      break;
     
    }
  }

  
  void _selectImage2(Future<File> pickImage, int imageNumber) async{
    File tempImg = await pickImage;
    switch(imageNumber){
      case 1:  setState(() => _image2 = tempImg);
      break;
     
    }
  }

 Widget _displayChild1() {
    if(_image1 == null){
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
        child: new Icon(Icons.add, color: grey,),
      );
    }else{
      return Image.file(_image1, fit: BoxFit.fill, width: double.infinity,);
    }
 }

 Widget _displayChild2() {
    if(_image2 == null){
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
        child: new Icon(Icons.add, color: grey,),
      );
    }else{
      return Image.file(_image2, fit: BoxFit.fill, width: double.infinity,);
    }
 }



  void validateAndUpload() async {
    if(_formKey.currentState.validate()){
        setState(() => isLoading= true);

        if(_image1 != null ){
         if(_image2 != null) {
                String imageUrl;
            final FirebaseStorage storage = FirebaseStorage.instance;
            final String picture1 = "${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
          StorageUploadTask task = storage.ref().child(picture1).putFile(_image1);

           task.onComplete.then((snapshot) async{

            imageUrl = await snapshot.ref.getDownloadURL();  
            String imagen = imageUrl;

            final String picture2 = "${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
            StorageUploadTask task2 = storage.ref().child(picture2).putFile(_image2);

            task2.onComplete.then((snapshot2) async{
            String imageUrl2 = await snapshot2.ref.getDownloadURL();  
            String imagen2 = imageUrl2;
            String categoriaP = '';
              if(_value==1) {
                  categoriaP='Programador';
              }
              else if(_value==2) {
                  categoriaP='Diseño Grafico';
              }
               else if(_value==3) {
                 categoriaP='Abogado';
              }
               else if(_value==4) {
                categoriaP='Abogado';
              }
              else if(_value==5) {
                 categoriaP='Enfermeria';
              }

                freelancerService.create(
             nombre: this.nombreController.text,
             categoriaId: this._value,
             profesion: this.profesionController.text,
             foto: imagen,
             foto2: imagen2,
             telefono: this.telefonoController.text,
             descripcion: this.descripcionController.text,
             correo: this.correoController.text,
             categoria: categoriaP
            );

            

            });

            
          _formKey.currentState.reset();
          setState(()=>isLoading=false);
      
          seanToastGreen("Freelancer agregado");
          changeScreen(context, FreelancerPage());
          } );
          

         }
         else {
           
           setState(()=> isLoading=false);
          Fluttertoast.showToast(msg: 'debes cargar la foto del freelancer');
         }
         
        }else{
           setState(()=> isLoading=false);
          Fluttertoast.showToast(msg: 'debes cargar la foto del freelancer');
        }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    this.profesionController.dispose();
    this.nombreController.dispose();
    this.telefonoController.dispose();
    this.correoController.dispose();
    this.profesionController.dispose();
    this.descripcionController.dispose();    
    this._formKey.currentState.dispose();
    this._image1 =null;
    this._image2 = null;
   
  }
}
