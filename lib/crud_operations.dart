import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'students.dart';
import 'package:path/path.dart';
import 'dart:async';



class DBHelper {
  static Database _db;
  static const String Id = 'controlum';
  static const String NAME = 'name';
  static const String PATERNO = 'paterno';
  static const String MATERNO = 'materno';
  static const String EMAIL = 'email';
  static const String PHONE = 'phone';
  static const String MATRICULA = 'matricula';
  static const String PHOTO = 'photo';
  static const String TABLE = 'Students';
  static const String DB_NAME = 'students04.db';

//creacion de la base de datos
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    else {
      _db = await initDb();
      return _db;
    }
  }

  initDb() async {
    io.Directory appDirectory = await getApplicationDocumentsDirectory();
    print(appDirectory);
    String path = join(appDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }


  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $TABLE ($Id INTEGER PRIMARY KEY, $NAME TEXT, $PATERNO TEXT, $MATERNO TEXT, $PHONE TEXT, $EMAIL TEXT, $MATRICULA TEXT, $PHOTO BLOB)");
  }

  Future<List<Student>> getStudents(String mat) async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE, columns: [Id, NAME, PATERNO, MATERNO, PHONE, EMAIL, MATRICULA, PHOTO]);
    List<Student> studentss = [];
    if(mat==null){
      if (maps.length > 0) {
        for (int i = 0; i < maps.length; i++) {
          studentss.add(Student.fromMap(maps[i]));
        }
      }}
    else{
      List<Map> maps = await dbClient.query(TABLE, columns: [Id, NAME, PATERNO, MATERNO, PHONE, EMAIL, MATRICULA, PHOTO], where: '$MATRICULA LIKE ?', whereArgs: [mat]);
      if (maps.length > 0) {
        for (int i = 0; i < maps.length; i++) {
          studentss.add(Student.fromMap(maps[i]));
        }
      }
    }
    return studentss;
  }
//getMatricula
  Future<int> getMatricula (String mat) async {
    var dbClient = await db;
    List<Map> maps1 = await dbClient.query(TABLE, columns: [Id,MATRICULA], where:'$MATRICULA=?', whereArgs: [mat]);
    int col = maps1.length;
    return col;
  }

//buscar
  Future<List<Student>> search (String mat) async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE, columns: [Id, NAME, PATERNO, MATERNO, PHONE, EMAIL, MATRICULA]);
    List<Student> studentss = [];
    if(mat==null){
      if (maps.length > 0) {
        for (int i = 0; i < maps.length; i++) {
          studentss.add(Student.fromMap(maps[i]));
        }

      }}
    else{
      List<Map> maps1 = await dbClient.query(TABLE, where: '$NAME=?', whereArgs: [mat.toUpperCase()]);
      List<Map> maps2 = await dbClient.query(TABLE, where: '$PATERNO=?', whereArgs: [mat.toUpperCase()]);
      List<Map> maps3 = await dbClient.query(TABLE, where: '$MATERNO=?', whereArgs: [mat.toUpperCase()]);
      List<Map> maps4 = await dbClient.query(TABLE, where: '$PHONE=?', whereArgs: [mat]);
      List<Map> maps5 = await dbClient.query(TABLE, where: '$EMAIL=?', whereArgs: [mat]);
      List<Map> maps6 = await dbClient.query(TABLE, where: '$MATRICULA=?', whereArgs: [mat]);
      List<Map> maps7 = await dbClient.query(TABLE, where: '$Id=?', whereArgs: [mat]);
      if (maps1.length > 0) {
        print("maps1");
        for (int i = 0; i < maps1.length; i++) {
          studentss.add(Student.fromMap(maps1[i]));
        }
      }
      else if (maps2.length > 0) {
        print("maps2");
        for (int i = 0; i < maps2.length; i++) {
          studentss.add(Student.fromMap(maps2[i]));
        }
      }
      else if (maps3.length > 0) {
        print("maps3");
        for (int i = 0; i < maps3.length; i++) {
          studentss.add(Student.fromMap(maps3[i]));
        }
      }
      else if (maps4.length > 0) {
        print("maps4");
        for (int i = 0; i < maps4.length; i++) {
          studentss.add(Student.fromMap(maps4[i]));
        }
      }
      else if (maps5.length > 0) {
        print("maps5");
        for (int i = 0; i < maps5.length; i++) {
          studentss.add(Student.fromMap(maps5[i]));
        }
      }
      else if (maps6.length > 0) {
        print("maps6");
        for (int i = 0; i < maps6.length; i++) {
          studentss.add(Student.fromMap(maps6[i]));
        }
      }
      else if (maps7.length > 0) {
        print("maps7");
        for (int i = 0; i < maps7.length; i++) {
          studentss.add(Student.fromMap(maps7[i]));
        }
      }
    }
    return studentss;
  }



//Save or insert
  Future<Student> insert(Student student) async {
    var dbClient = await db;
    student.controlum = await dbClient.insert(TABLE, student.toMap());
    return student;
  }

//Delete
  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE, where: '$Id = ?', whereArgs: [id]);
  }

//Update
  Future<int> update(Student student) async {
    var dbClient = await db;
    return await dbClient.update(TABLE, student.toMap(), where: '$Id = ?',
        whereArgs: [student.controlum]);
  }

  Future<List<Student>> gets() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE, columns: [Id, NAME, PATERNO, MATERNO, PHONE, EMAIL, MATRICULA, PHOTO]);
    List<Student> studentss = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        studentss.add(Student.fromMap(maps[i]));
      }
    }
    return studentss;
  }

  Future<List<Student>>select(String buscar) async{
    final bd = await db;
    //CONSULTA DE LA BASE PARA EL SELECT
    List<Map> maps = await bd.rawQuery("SELECT * FROM $TABLE WHERE $MATRICULA LIKE '$buscar%'");
    List<Student> studentss =[];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++){
        studentss.add(Student.fromMap(maps[i]));
      }
    }
    return studentss;
  }

//Close Database
  Future closedb() async {
    var dbClient = await db;
    dbClient.close();
  }
}