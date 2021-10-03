import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(body1: TextStyle(fontSize: 21))
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime fechaIni;
  DateTime fechaFin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(fechaIni == null ? 'No has seleccionado esta fecha aun' : fechaIni.toString()),
            RaisedButton(
              child: Text('Fecha Inicial'),
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: fechaIni == null ? DateTime.now() : fechaIni,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030)
                ).then((date) {
                  setState(() {
                    fechaIni = date;
                  });
                });
              },
            ),
            Text(fechaFin == null ? 'No has seleccionado esta fecha aun' : fechaFin.toString()),
            RaisedButton(
              child: Text('Fecha Final'),
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: fechaFin == null ? DateTime.now() : fechaFin,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030)
                ).then((date) {
                  setState(() {
                    fechaFin = date;



                  });
                });
              },
            )
          ],
        ),
      ),
    );
  }
}