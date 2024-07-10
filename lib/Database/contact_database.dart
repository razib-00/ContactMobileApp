import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as Path;
import 'package:test_028/Model/contact_model.dart';

class Db_Helper {
  static const String _contactTable = ''' CREATE TABLE $CreateTable(
  $tblColId INTEGER PRIMARY KEY AUTOINCREMENT,
  $tblColName TEXT,
  $tblColMobile TEXT,
  $tblColEmail TEXT,
  $tblColAddress TEXT,
  $tblColGPO TEXT,
  $tblColCompany TEXT,
  $tblColDesignation TEXT,
  $tblColWebsite TEXT,
  $tblColImage TEXT,
  $tblColFavorite INTEGER
  )''';

  static Future<Database> open() async {
    final rootpath = await getDatabasesPath();
    final dbpath = Path.join(rootpath, "test028_db.db");
    return openDatabase(dbpath, version: 2, onCreate: (db, version) async {
      db.execute(_contactTable);
    },onUpgrade: (db,oldversion,newversion)async{
      if(oldversion==1){
        db.execute('alter table $CreateTable add column $tblColFavorite integer not null default 0');
      }
    });
  }

//insert
  static Future<int> insertContact(ContactModel contactModel) async {
    final db = await open();
    return db.insert(CreateTable, contactModel.toMap());
  }

  //get all
  static Future<List<ContactModel>> getAllContact() async {
    final db = await open();
    final List<Map<String, dynamic>> maplist = await db.query(CreateTable);
    return List.generate(
        maplist.length, (index) => ContactModel.formMap(maplist[index]));
  }

  //get id
  static Future<ContactModel> getContactId(int id) async {
    final db = await open();
    List<Map<String, dynamic>> maplist =
        await db.query(CreateTable, where: '$tblColId = ?', whereArgs: [id]);
    return ContactModel.formMap(maplist.first);
  }

  //delete method
  static Future<int> deleteContact(int id) async {
    final db = await open();
    return db.delete(CreateTable, where: '$tblColId = ?', whereArgs: [id]);
  }
  //Update favorite
  static Future<int>updateFavorite(int id,int value)async{
    final db=await open();
    return db.update(CreateTable,{tblColFavorite:value},where:'$tblColId=?',whereArgs: [id]);
  }
}
