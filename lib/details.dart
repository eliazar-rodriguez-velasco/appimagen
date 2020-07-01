import 'students.dart';
import 'package:flutter/material.dart';
import 'convertir.dart';


class DetailPage extends StatelessWidget {
  final Student student;

  DetailPage(this.student);

  int opcion;
  final formkey = new GlobalKey<FormState>();
  int currentUserId;
  var bdHelper;

  String name;
  String paterno;
  String materno;
  String email;
  String phone;
  String matricula;
  String photo;
  String image;
  String valor;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text(student.name.toString().toUpperCase() +
              " " +
              student.paterno.toString().toUpperCase() +
              " " +
              student.materno.toString().toUpperCase()),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: Stack(
          children: <Widget>[
            Positioned(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width - 10,
              left: 5,
              top: 25.0,
              child: Container(
                child: SingleChildScrollView(
                  child: Card(
                    color: Colors.white12,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(
                          height: 30.0,
                        ),
                        //FOTO
                        CircleAvatar(
                          minRadius: 100.0,
                          maxRadius: 100.0,
                          backgroundColor: Colors.black,
                          backgroundImage:
                          Convertir.imageFromBase64sString(student.photo)
                              .image,
                        ),
                        new Padding(
                          padding: EdgeInsets.all(10.0),
                        ),

                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            //NOMBRE
                            Text(
                              student.name.toString().toUpperCase(),
                              style: TextStyle(
                                  fontSize: 40.0,
                                  color: Colors.cyan,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                        new Padding(padding: EdgeInsets.all(6.0)),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              student.paterno.toString().toUpperCase() +
                                  " " +
                                  student.materno.toString().toUpperCase(),
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.cyan,
                                // fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                        Divider(
                            color: Colors.black,
                            indent: 40,
                            endIndent: 40,
                            thickness: 4.0),

                        //MATRICULA
                        new Padding(
                          padding: EdgeInsets.all(10.0),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 90,
                          child: RaisedButton.icon(
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                            label: Text(
                              "Matricula: " + "     " + "${student.matricula}",
                              style: TextStyle(color: Colors.white, fontSize: 15.0),
                            ),
                            icon: Icon(
                              Icons.card_membership,
                              color: Colors.white,
                              size: 30.0,
                            ),
                            color: Colors.cyan,
                          ),
                        ),
                        //EMAIL
                        new Padding(
                          padding: EdgeInsets.all(10.0),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width ,
                          child: RaisedButton.icon(
                            onPressed: () {
                              print('Button Clicked.');
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                            label: Text(
                              "Email: " + "     " + "${student.email}",
                              style: TextStyle(color: Colors.white),
                            ),
                            icon: Icon(
                              Icons.mail,
                              color: Colors.white,
                              size: 30.0,
                            ),
                            color: Colors.cyan,
                          ),
                        ),
                        new Padding(
                          padding: EdgeInsets.all(10.0),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width - 90,
                            child: RaisedButton.icon(
                              onPressed: () {
                                print('Button Clicked.');
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                              label: Text(
                                "Telefono: " + "     " + "${student.phone}",
                                style: TextStyle(color: Colors.white),
                              ),
                              icon: Icon(
                                Icons.phone,
                                color: Colors.white,
                                size: 30.0,
                              ),
                              color: Colors.cyan,
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
