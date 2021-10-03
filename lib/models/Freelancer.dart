

class Freelancer {
  String _id;
  String _nombre;
  String _descripcion;
  String _foto;
  int _categoriaId;
  String _categoria;
  String _telefono;
  String _correo;
  String _foto2;
  String _profesion;
 


Freelancer(String id, String nombre,String descripcion, String foto,String foto2,
int categoriaId, String categoria, String telefono,  String correo, String profesion ) {
  this._id=id;
  this._nombre=nombre;
  this._descripcion=descripcion;
  this._foto=foto;
  this._foto2=foto2;
  this._categoriaId=categoriaId;
  this._telefono=telefono;
  this._categoria=categoria;
  this._correo = correo;
  this._profesion = profesion;
}

int get categoriaId => _categoriaId;
String get categoria => _categoria;
String get correo => _correo;
String get descripcion => _descripcion;
String get foto => _foto;
String get foto2 => _foto2;
String get id => _id;
String get nombre => _nombre;
String get telefono => _telefono;
String get profesion => _profesion;


set nombre(String nombre) {
  this.nombre=nombre;
}

set correo(String correo) {
  this.correo=correo;
}

set id(String id) {
  this.id=id;
}


set descripcion(String descripcion) {
  this.descripcion=descripcion;
}

set profesion(String profesion) {
  this.profesion=profesion;
}

set categoria(String categoria) {
  this.categoria=categoria;
}

set foto(String foto) {
  this.foto=foto;
}


set foto2(String foto2) {
  this.foto2=foto2;
}
set categoriaId(int categoriaId) {
  this.categoriaId=categoriaId;
}


set telefono(String telefono) {
  this.telefono=telefono;
}


}