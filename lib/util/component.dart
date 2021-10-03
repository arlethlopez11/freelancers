class Component {
  String _id;
  String _nombre;
  String _imagen;
  String _datoA;
  String _datoB;
  String _datoC;
  String _labelA;
  String _labelB;
  String _labelC;
  DateTime _fecha;

Component({String id, String nombre,String imagen, String datoA,
String datoB, String datoC, String labelA, String labelB, String labelC }) {
  this._id=id;
  this._nombre=nombre;
  this._imagen=imagen;
  this._datoA=datoA;
  this._datoB=datoB;
  this._datoC=datoC;
  this._labelA=labelA;
  this._labelB=labelB;
  this._labelC=labelC;
}

Component.medio(String id, String nombre,String imagen, String datoA,
String datoB, String labelA, String labelB) {
this._id=id;
  this._nombre=nombre;
  this._imagen=imagen;
  this._datoA=datoA;
  this._datoB=datoB;
  this._labelA=labelA;
  this._labelB=labelB;
}

Component.medioConFecha(String id, String nombre,String imagen, String datoA,
String datoB, String labelA, String labelB, DateTime fecha) {
this._id=id;
  this._nombre=nombre;
  this._imagen=imagen;
  this._datoA=datoA;
  this._datoB=datoB;
  this._labelA=labelA;
  this._labelB=labelB;
  this._fecha=fecha;
}



Component.simpleConFecha(String id, String nombre,String imagen, String datoA,String labelA,
DateTime fecha) {
this._id=id;
  this._nombre=nombre;
  this._imagen=imagen;
  this._datoA=datoA;
  this._labelA=labelA;  
  this._fecha=fecha;
}


Component.simple(String id, String nombre,String imagen, String datoA,String labelA) {
this._id=id;
  this._nombre=nombre;
  this._imagen=imagen;
  this._datoA=datoA;
  this._labelA=labelA;  
}

String get id => _id;
String get nombre => _nombre;
String get imagen => _imagen;
String get datoA => _datoA;
String get datoB => _datoB;
String get datoC => _datoC;

String get labelA => _labelA;
String get labelB => _labelB;
String get labelC => _labelC;
DateTime get fecha => _fecha;

set nombre(String nombre) {
  this.nombre=nombre;
}

set id(String id) {
  this.id=id;
}

set datoA(String datoA) {
  this.datoA=datoA;
}
set datoB(String datoB) {
  this.datoB=datoB;
}
set datoC(String datoC) {
  this.datoC=datoC;
}


set imagen(String imagen) {
  this.imagen=imagen;
}



set labelA(String labelA) {
  this.labelA=labelA;
}

set labelB(String labelB) {
  this.labelB=labelB;
}

set labelC(String labelC) {
  this.labelC=labelC;
}


set fecha(DateTime fecha) {
  this.fecha=fecha;
}


}