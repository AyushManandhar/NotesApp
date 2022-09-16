import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  Future<Database> createfolder() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.No implementation found for method getDatabasesPath on channel com.tekartik.sqflitedb');
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Notes (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, note TEXT)');
      
    
    });

    return database;
  }
}
