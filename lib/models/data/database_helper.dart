import 'package:mytask/models/task_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await _initialisation();
      return _db;
    }
    return _db;
  }

  //-----------------------------------------------------------------
  Future<Database> _initialisation() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, "tasks.db");

    Database mydb = await openDatabase(path, onCreate: _createDb, version: 1);
    return mydb;
  }
  //-------------------------------------------------------------------------

  _createDb(Database db, int version) async {
    await db.execute('''
        CREATE TABLE "tasks" (
        "id" INTEGER PRIMARY KEY AUTOINCREMENT,
        "title" TEXT NOT NULL,
        "description" TEXT,
        "dueDate" TEXT NOT NULL,
        "priority" TEXT,
        "status" TEXT
        )
    ''');
  }

  //-----------------------------------------------------------

  Future<int> insertData(Task task) async {
    Database? mydb = await db;
    return await mydb!.insert('tasks', task.toMap());
  }

  Future<List<Task>> getAllData() async {
    Database? mydb = await db;
    List<Map<String, dynamic>> maps = await mydb!.query('tasks');
    return maps.map((map) => Task.fromMap(map)).toList();
  }

  Future<int> updateData(Task task) async {
    Database? mydb = await db;
    return await mydb!.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> deleteData(int id) async {
    Database? mydb = await db;
    return await mydb!.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  //-------------------------------------------------------------------------
}
