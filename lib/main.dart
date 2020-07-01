import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'actualizar.dart';
import 'borrar.dart';
import 'buscar.dart';
import 'convertir.dart';
import 'crud_operations.dart';
import 'insertar.dart';
import 'seleccionar.dart';
import 'students.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      home: homePage(),
    );
  }
}

class homePage extends StatefulWidget {
  @override
  _myHomePageState createState() => new _myHomePageState();
}

class _myHomePageState extends State<homePage> {
  //Variables referentes al manejo de la bd
  Future<List<Student>> Studentss;
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerPaterno = TextEditingController();
  TextEditingController controllerMaterno = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerMatricula = TextEditingController();
  String name;
  String paterno;
  String materno;
  String email;
  String phone;
  String matricula;
  int currentUserId;
  var bdHelper;
  bool isUpdating;
  final _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    bdHelper = DBHelper();
    isUpdating = false;
    refreshList();
  }

  void refreshList() {
    setState(() {
      Studentss = bdHelper.getStudents(null);
    });
  }

  void cleanData() {
    controllerName.text = "";
    controllerPaterno.text = "";
    controllerMaterno.text = "";
    controllerPhone.text = "";
    controllerEmail.text = "";
    controllerMatricula.text = "";
  }

  Widget menu() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            padding: EdgeInsets.all(50.0),
            child: Text(
              "MENU",
              style: TextStyle(color: Colors.white, fontSize: 55),
              textAlign: TextAlign.center,
            ),
            decoration: BoxDecoration(color: Colors.cyan),
          ),
          ListTile(
            leading: Icon(Icons.search, size: 28.0, color: Colors.cyan),
            title: Text('BUSCAR', style: TextStyle(fontSize: 20.0, color: Colors.cyan)),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => busqueda()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings_backup_restore,
              color: Colors.cyan,
              size: 28.0,
            ),
            title: Text(
              'ACTUALIZAR',
              style: TextStyle(fontSize: 20.0, color: Colors.cyan),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => actualizar()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.add,
              color: Colors.cyan,
              size: 28.0,
            ),
            title: Text('INSERTAR',
                style: TextStyle(fontSize: 20.0, color: Colors.cyan)),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => insertar()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.delete,
              color: Colors.cyan[800],
              size: 28.0,
            ),
            title: Text('ELIMINAR',
                style: TextStyle(fontSize: 20.0, color: Colors.cyan)),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => borrar()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.select_all,
              color: Colors.cyan,
              size: 28.0,
            ),
            title: Text('SELECCIONAR',
                style: TextStyle(fontSize: 20.0, color: Colors.cyan)),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => seleccionar()));
            },
          ),

        ],
      ),
    );
  }

  //Mostrar datos
  SingleChildScrollView dataTable(List<Student> Studentss) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: [
              DataColumn(
                label: Text(
                  "Control",
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),
              ),
              DataColumn(
                label: Text("Matricula",
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown)),
              ),
              DataColumn(
                label: Text("Name",
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown)),
              ),
              DataColumn(
                label: Text("A Paterno",
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown)),
              ),
              DataColumn(
                label: Text("A Materno",
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown)),
              ),
              DataColumn(
                label: Text("telefono",
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown)),
              ),
              DataColumn(
                label: Text("Email",
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown)),
              ),
              DataColumn(label: Text("Photo",
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown)),)
            ],
            rows: Studentss.map((student) => DataRow(cells: [
              DataCell(Text(student.controlum.toString(),
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown))),
              DataCell(Text(student.matricula.toString(),
                  style:
                  TextStyle(fontSize: 16.0, color: Colors.cyan))),
              DataCell(
                Text(student.name.toString(),
                    style: TextStyle(
                        fontSize: 16.0, color: Colors.cyan)),
              ),
              DataCell(Text(student.paterno.toString(),
                  style:
                  TextStyle(fontSize: 16.0, color: Colors.cyan))),
              DataCell(Text(student.materno.toString(),
                  style:
                  TextStyle(fontSize: 16.0, color: Colors.cyan))),
              DataCell(Text(student.phone.toString(),
                  style:
                  TextStyle(fontSize: 16.0, color: Colors.cyan))),
              DataCell(Text(student.email.toString(),
                  style:
                  TextStyle(fontSize: 16.0, color: Colors.cyan))),
              DataCell(Convertir.imageFromBase64sString(student.photo),
              ),
            ])).toList(),
          ),
        ));
  }

  Widget list() {
    return Expanded(
      child: FutureBuilder(
        future: Studentss,
        // ignore: missing_return
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return dataTable(snapshot.data);
          }
          if (snapshot.data == null || snapshot.data.length == 0) {
            return Text("Not data founded");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      key: _scaffoldkey,
      drawer: menu(),
      appBar: new AppBar(
        title: Text("Basic SQL operations"),
        backgroundColor: Colors.black,
      ),

      body: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            list(),
            Row(

              children: <Widget>[
                Center(
                    child: Container(
                        padding: EdgeInsets.all(15.0),
                        width: MediaQuery.of(context).size.width,
                        child: MaterialButton(
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(
                                  color: Colors.black, width: 5.0)),
                          onPressed: refreshList,
                          child: Text(
                            'UPDATE',
                            style: TextStyle(fontSize: 25.0),
                          ),
                        )))
              ],
            ),

            //NavDrawer(),
          ],
        ),
      ),
    );
  }
}
