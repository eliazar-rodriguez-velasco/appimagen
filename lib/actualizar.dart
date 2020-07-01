import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'convertir.dart';
import 'students.dart';
import 'crud_operations.dart';


class actualizar extends StatefulWidget {
  @override
  _actualizar createState() => new _actualizar();
}

class _actualizar extends State<actualizar> {
  //Variable referentes al manejo de la BD
  Future<List<Student>> Studentss;
  TextEditingController controllerValue = TextEditingController();
  TextEditingController controllerPhoto = TextEditingController();
  String name;
  String paterno;
  String materno;
  String email;
  String phone;
  String matricula;
  String photo;
  String image;
  String valor;
  int currentUserId;
  int opcion;

  String descriptive_text = "Student Name";

  final formkey = new GlobalKey<FormState>();
  var dbHelper;
  bool isUpdating;
  bool change; //Nos ayuda a cambiar al momento de actualizar la foto

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    isUpdating = false;
    change = true;
    refreshList();
  }

  //select
  void refreshList() {
    setState(() {
      Studentss = dbHelper.gets();
    });
  }

  void cleanData() {
    controllerValue.text = "";
    controllerPhoto.text = "";
  }

  void updateData() {
    print("Valor de Opción");
    print(opcion);
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      //NOMBRE
      if (opcion == 1) {
        Student stu = Student(currentUserId, valor, paterno, materno, phone,
            email, matricula, image);
        dbHelper.update(stu);
      }
      //APELLIDO PATERNO
      else if (opcion == 2) {
        Student stu = Student(currentUserId, name, valor, materno, phone, email,
            matricula, image);
        dbHelper.update(stu);
      }
      //APELLIDO MATERNO
      else if (opcion == 3) {
        Student stu = Student(currentUserId, name, paterno, valor, phone, email,
            matricula, image);
        dbHelper.update(stu);
      }
      //PHONE
      else if (opcion == 4) {
        Student stu = Student(currentUserId, name, paterno, materno, valor,
            email, matricula, image);
        dbHelper.update(stu);
      }
      //EMAIL
      else if (opcion == 5) {
        Student stu = Student(currentUserId, name, paterno, materno, phone,
            valor, matricula, image);
        dbHelper.update(stu);
      }
      //MATRICULA
      else if (opcion == 6) {
        Student stu = Student(
            currentUserId, name, paterno, materno, phone, email, valor, image);
        dbHelper.update(stu);
      }
      //photo
      else if (opcion == 7) {
        Student stu = Student(currentUserId, name, paterno, materno, phone,
            email, matricula, valor);
        dbHelper.update(stu);
      }
      cleanData();
      refreshList();
    }
  }

  //Metodo para imagen
  pickImagefromGallery(BuildContext context) {
    ImagePicker.pickImage(source: ImageSource.gallery).then((imgFile) {
      String imgString = Convertir.base64String(imgFile.readAsBytesSync());
      image = imgString;
      //Funciona para la obtencion de imagen ya sea galeria o camera
      Navigator.of(context).pop();
      controllerValue.text = image;
      return image;
    });
  }

  pickImagefromCamera(BuildContext context) {
    ImagePicker.pickImage(source: ImageSource.camera).then((imgFile) {
      String imgString = Convertir.base64String(imgFile.readAsBytesSync());
      image = imgString;
      Navigator.of(context).pop();
      controllerValue.text = image;
      return image;
    });
  }

  // imagen camara o galeria
  Future<void> _selectfoto(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(
                "elija para su nueva foto",
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.black,
              content: SingleChildScrollView(
                child: ListBody(children: <Widget>[
                  GestureDetector(
                    child: Text("Galeria"),
                    onTap: () {
                      pickImagefromGallery(context);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                  ),
                  GestureDetector(
                    child: Text(
                      "Camara",
                    ),
                    onTap: () {
                      pickImagefromCamera(context);
                    },
                  )
                ]),
              ));
        });
  }

  Widget form() {
    return Form(
      key: formkey,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            new SizedBox(height: 50.0),
            TextFormField(
              controller: change ? controllerValue : controllerPhoto,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: 'actualizar',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  icon: Icon(
                    Icons.card_membership,
                    size: 35.0,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0))),
              validator: (val) => change == false
                  ? val.length == 0
                  ? 'Enter Data'
                  : controllerPhoto.text != "Campo lleno"
                  ? "solo se puede con imagebes"
                  : null
                  : val.length == 0 ? 'Enter Data' : null,
              onSaved: (val) =>
              change ? valor = controllerValue.text : valor = image,
            ),
            SizedBox(
              height: 30,
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.black),
                  ),
                  onPressed: updateData,
                  //child: Text(isUpdating ? 'Update ' : 'Add Data'),
                  child: Text('Update Data'),
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.black),
                  ),
                  onPressed: () {
                    setState(() {
                      isUpdating = false;
                    });
                    cleanData();
                    refreshList();
                  },
                  child: Text("Cancel"),
                ),
              ],
            )
          ],
        ),
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
                label: Text("Paterno",
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown)),
              ),
              DataColumn(
                label: Text("Materno",
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown)),
              ),
              DataColumn(
                label: Text("Phone",
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
              DataColumn(
                label: Text("Photo",
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown)),
              )
            ],
            rows: Studentss.map((student) => DataRow(cells: [
              DataCell(Text(student.controlum.toString(),
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown))),
              DataCell(
                  Text(student.matricula.toString(),
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.cyan)), onTap: () {
                setState(() {
                  isUpdating = true;
                  change = true;
                  currentUserId = student.controlum;
                  image = student.photo;
                  name = student.name;
                  paterno = student.paterno;
                  materno = student.materno;
                  phone = student.phone;
                  email = student.email;
                  matricula = student.matricula;
                  opcion = 6;
                });
                controllerValue.text = student.matricula;
              }),
              DataCell(
                  Text(student.name.toString(),
                      style: TextStyle(
                          fontSize: 16.0, color: Colors.cyan)), onTap: () {
                setState(() {
                  isUpdating = true;
                  change = true;
                  currentUserId = student.controlum;
                  image = student.photo;
                  name = student.name;
                  paterno = student.paterno;
                  materno = student.materno;
                  phone = student.phone;
                  email = student.email;
                  matricula = student.matricula;
                  opcion = 1;
                });
                controllerValue.text = student.name;
              }
              ),
              DataCell(Text(student.paterno.toString(),
                  style:
                  TextStyle(fontSize: 16.0, color: Colors.cyan)), onTap: () {
                setState(() {
                  isUpdating = true;
                  change = true;
                  currentUserId = student.controlum;
                  image = student.photo;
                  name = student.name;
                  paterno = student.paterno;
                  materno = student.materno;
                  phone = student.phone;
                  email = student.email;
                  matricula = student.matricula;
                  opcion = 2;
                });
                controllerValue.text = student.paterno;
              }),
              DataCell(Text(student.materno.toString(),
                  style:
                  TextStyle(fontSize: 16.0, color: Colors.cyan)), onTap: () {
                setState(() {
                  isUpdating = true;
                  change = true;
                  currentUserId = student.controlum;
                  image = student.photo;
                  name = student.name;
                  paterno = student.paterno;
                  materno = student.materno;
                  phone = student.phone;
                  email = student.email;
                  matricula = student.matricula;
                  opcion = 3;
                });
                controllerValue.text = student.materno;
              }),
              DataCell(Text(student.phone.toString(),
                  style:
                  TextStyle(fontSize: 16.0, color: Colors.cyan)), onTap: () {
                setState(() {
                  isUpdating = true;
                  change = true;
                  currentUserId = student.controlum;
                  image = student.photo;
                  name = student.name;
                  paterno = student.paterno;
                  materno = student.materno;
                  phone = student.phone;
                  email = student.email;
                  matricula = student.matricula;
                  opcion = 4;
                });
                controllerValue.text = student.phone;
              }),
              DataCell(Text(student.email.toString(),
                  style:
                  TextStyle(fontSize: 16.0, color: Colors.cyan
                  )),  onTap: () {
                setState(() {
                  isUpdating = true;
                  change = true;
                  currentUserId = student.controlum;
                  image = student.photo;
                  name = student.name;
                  paterno = student.paterno;
                  materno = student.materno;
                  phone = student.phone;
                  email = student.email;
                  matricula = student.matricula;
                  opcion = 5;
                });
                controllerValue.text = student.email;
              }),
              DataCell(
                  Convertir.imageFromBase64sString(student.photo), onTap: () {
                _selectfoto(context);
                print(Convertir.imageFromBase64sString(student.photo));
                print(image);
                setState(() {
                  isUpdating = true;
                  change = true;
                  currentUserId = student.controlum;
                  image = student.photo;
                  name = student.name;
                  paterno = student.paterno;
                  materno = student.materno;
                  phone = student.phone;
                  email = student.email;
                  matricula = student.matricula;
                  opcion = 7;
                });
                controllerValue.text = student.photo;
              }
              ),
            ])).toList(),
          ),
        ));
  }

  Widget list() {
    return Expanded(
      child: FutureBuilder(
        future: Studentss,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return dataTable(snapshot.data);
          }
          if (snapshot.data == null || snapshot.data.length == 0) {
            return Text("No data founded!");
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
      resizeToAvoidBottomInset: false, //new line
      appBar: new AppBar(
        title: Text('Actualizar'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            form(),
            list(),
          ],
        ),
      ),
    );
  }
}
