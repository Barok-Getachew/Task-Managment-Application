import '../utils/app_exports.dart';
import '../models/task.dart';

class StorageService {
  static Database? _db;

  static Future<Database> initDB() async {
    if (_db != null) return _db!;
    _db = await openDatabase('tasks.db', version: 1, onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, dueDate TEXT, isCompleted INTEGER)',
      );
    });
    return _db!;
  }

  static Future<void> saveTask(Task task) async {
    final db = await initDB();
    await db.insert('tasks', task.toJson());
  }

  static Future<void> updateTask(Task task) async {
    final db = await initDB();
    await db
        .update('tasks', task.toJson(), where: 'id = ?', whereArgs: [task.id]);
  }

  static Future<List<Task>> getTasks() async {
    final db = await initDB();
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    return List.generate(maps.length, (i) => Task.fromJson(maps[i]));
  }

  static Future<void> deleteTask(int id) async {
    final db = await initDB();
    await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id], // Match the task id
    );
  }
}
