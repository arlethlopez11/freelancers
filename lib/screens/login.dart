import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:freelancers/db/admins.dart';
import 'package:freelancers/db/freelancer.dart';
import 'package:freelancers/models/SeanLista.dart';
import 'package:freelancers/models/Freelancer.dart';
import 'package:freelancers/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:freelancers/screens/freelancer/freelancer_page.dart';
import 'package:freelancers/util/navegacion.dart';
import 'package:freelancers/util/globals.dart' as globals;

import 'freelancer/add_freelancer.dart';


class Login extends StatefulWidget {
  @override 
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  
 final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();
  final _codeController = TextEditingController();
  FreelancerService freelancerService = FreelancerService();
  bool isLogedin=false;
  bool loading=false;

@override
void initState() {
super.initState();
_getFreelancers();
}


_getFreelancers() async {
  List<Freelancer> freelancers = await freelancerService.getFreelancers();
  
      

 globals.listaFreelancers=freelancers;  
  isSignedIn();
} 

  void isSignedIn() async {
      setState(() {
        loading=true;
      });
      
// it is possible that it works
       await firebaseAuth.currentUser().then((user){
          if(user != null) {
            setState(()=> isLogedin = true);
            
          }
      });

      if(isLogedin) {
        changeScreenReplacemente(context, FreelancerPage());  
      }

      setState(() {
        loading=false;
      });
    }

  loginUser2(String phone, String name, BuildContext context) {
      changeScreen(context,FreelancerPage());
  }

  Future<bool> loginUser(String phone, String name,BuildContext context) async{
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async{
          Navigator.of(context).pop();

          AuthResult result = await _auth.signInWithCredential(credential);

          FirebaseUser user = result.user;

          if(user != null){
             globals.listaFreelancers = await freelancerService.getFreelancers();
                  SharedPreferences.getInstance().then((preferences){
                    preferences.setString('phone',phone);
                    preferences.setString('usuario',name);
                   
                    
                    changeScreenReplacemente(context, FreelancerPage());
                    });
            
          }else{
            print("Error");
          }

          //This callback would gets called when verification is done auto maticlly
        },
        verificationFailed: (AuthException exception){
          print(exception.message);
          print(exception.code);
          print(exception.toString());
        },
        codeSent: (String verificationId, [int forceResendingToken]){
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: Text("ingresar codigo"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: _codeController,
                    ),
                  ],
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Confirmar"),
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: () async{
                      final code = _codeController.text.trim();
                      AuthCredential credential = PhoneAuthProvider.getCredential(verificationId: verificationId, smsCode: code);

                      AuthResult result = await _auth.signInWithCredential(credential);

                      FirebaseUser user = result.user;

                      if(user != null){
                      
                  SharedPreferences.getInstance().then((preferences){
                    preferences.setString('phone',phone);
                    preferences.setString('usuario',name);
                    changeScreenReplacemente(context, FreelancerPage());
                    });

                       
                      }else{
                        print("Error");
                      }
                    },
                  )
                ],
              );
            }
          );
        },
        codeAutoRetrievalTimeout: null
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
             Image.asset('images/background.jpg',
           fit: BoxFit.fill,
           width: double.infinity,
           height: double.infinity,
           ),
         Container(
           color: Colors.black.withOpacity(0.4),
           width: double.infinity,
           height: double.infinity,
         ),
               Container(
            padding: EdgeInsets.all(32),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Iniciar Sesión", style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w500),),

                  SizedBox(height: 16,),

                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.grey[200])
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.grey[300])
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: "Número de Telefono"

                    ),
                    controller: _phoneController,
                  ),
                  Divider(),
                  TextFormField(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.grey[200])
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.grey[300])
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: "Nombre",
                        labelText: "Nombre"

                    ),
                    controller: _nameController,
                  ),

                  SizedBox(height: 16,),


                  Container(
                    width: double.infinity,
                    child: FlatButton(
                      child: Text("INICIAR SESION"),
                      textColor: Colors.white,
                      padding: EdgeInsets.all(16),
                      onPressed: () {
                        final phone = '+502'+_phoneController.text.trim();
                        final name = _nameController.text;

                        loginUser(phone, name, context);

                      },
                      color: Colors.blue,
                    ),
                  )
                ],
              ),
            ),
          ),
          
      Visibility(
        visible: loading ?? true,
        child: Container( 
          color: Colors.white.withOpacity(0.7),
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
          )
        )
      )
          ],
          
        )
    );
  }
}
