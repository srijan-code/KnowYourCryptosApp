import 'dart:io';
import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'db_crypto.dart';



class DataBaseHelper{
 static final DataBaseHelper instance= DataBaseHelper._init();
 static Database?_database;

 DataBaseHelper._init();

 Future<Database> get database async{
   if(_database!=null)
     return _database!;
   _database=await _initDB('crypto.db');
   return _database!;
 }

 Future<Database> _initDB(String filePath) async{
   final dbPath = await getDatabasesPath();
   final path = join(dbPath,filePath);
   return await openDatabase(path, version: 1, onCreate: _createDB);
 }

  Future _createDB(Database db, int version) async{
   final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';


   await db.execute('''
   CREATE TABLE $tableCrypto(
   ${FavCryptoFields.id} $idType,
   ${FavCryptoFields.name} $String,
   ${FavCryptoFields.symbol} $String,
   ${FavCryptoFields.imageURL} $String
   )
   ''');
  }

  Future<FavCrypto> create(FavCrypto favcrypto) async{
   final db= await instance.database;
   final id = await db.insert(tableCrypto, favcrypto.toJson());
   return favcrypto.copy(id:id);
  }



 Future<FavCrypto> readFav(int id) async{
   final db=await instance.database;

   final maps= await db.query(
     tableCrypto,
     columns: FavCryptoFields.values,
     where: '${FavCryptoFields.id} = ?',
     whereArgs: [id],
   );
   if(maps.isNotEmpty)
   {
     return FavCrypto.fromJson(maps.first);
   }
   else
   {
     throw Exception('ID $id not found');
   }
 }

 Future<List<FavCrypto>> readAllFavCrypto() async{
   final db = await instance.database;

   final result = await db.query(tableCrypto);
   return result.map((json) => FavCrypto.fromJson(json)).toList();
 }

 Future<int> update(FavCrypto favcrypto) async{
   final db= await instance.database;

   return db.update(tableCrypto, favcrypto.toJson(),where: '${FavCryptoFields.id}=?',whereArgs: [favcrypto.id]);
 }

 Future<int> delete(int id) async{
   final db=await instance.database;

   return await db.delete(tableCrypto, where: '${FavCryptoFields.id}=?',whereArgs: [id]);
 }

  Future close() async{
   final db= await instance.database;
   db.close();
  }




}