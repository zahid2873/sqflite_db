import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_db/model/contact.dart';

class MyDbHelper{
  static Future<Database> initDb() async{
    String dbPath = await getDatabasesPath();
    var path = join (dbPath,'contact.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }
  static _onCreate(Database db,int version){
    var sql = '''CREATE TABLE tbl_contact (id INTEGER PRIMARY KEY, name TEXT, phone TEXT)''';
    db.execute(sql);
  }
  static Future<int> createContact(Contact contact)async{
    Database db = await MyDbHelper.initDb();
    return await db.insert('tbl_contact', contact.toMap());
  }
  static Future<List<Contact>>readContact()async{
    Database db = await MyDbHelper.initDb();
    var contact = await db.query('tbl_contact');
    List<Contact> contactList = contact.isEmpty? contact.map((e) => Contact.fromMap(e)).toList():[];
    return contactList;
  }
  static Future<int> updateConatct (Contact contact)async{
    Database db = await MyDbHelper.initDb();
    return await db.update('tbl_contact', contact.toMap(), where: 'id =?',whereArgs: [contact.id]);
  }

  static Future<int> deleteContact(int id ) async{
    Database db = await MyDbHelper.initDb();
    return await db.delete('tbl_contact',where: 'id=?',whereArgs: [id]);
  }

}