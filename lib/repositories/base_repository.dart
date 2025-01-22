import 'package:sqflite/sqflite.dart';
import 'package:stock_pro/repositories/helpers/database_helper.dart';

abstract class BaseRepository<T> {
  final DatabaseHelper dbHelper;
  final String tableName;

  BaseRepository({
    required this.dbHelper,
    required this.tableName,
  });

  // Convert model to Map
  Map<String, dynamic> toMap(T item);

  // Convert Map to model
  T fromMap(Map<String, dynamic> map);

  Future<int> insert(T item) async {
    final Database db = await dbHelper.database;
    return await db.insert(
      tableName,
      toMap(item),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> update(
      T item, String whereClause, List<dynamic> whereArgs) async {
    final Database db = await dbHelper.database;
    return await db.update(
      tableName,
      toMap(item),
      where: whereClause,
      whereArgs: whereArgs,
    );
  }

  Future<int> delete(String whereClause, List<dynamic> whereArgs) async {
    final Database db = await dbHelper.database;
    return await db.delete(
      tableName,
      where: whereClause,
      whereArgs: whereArgs,
    );
  }

  Future<List<T>> getAll() async {
    final Database db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (index) => fromMap(maps[index]));
  }

  Future<T?> getById(int id) async {
    final Database db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return fromMap(maps.first);
  }

  Future<List<T>> query({
    String? where,
    List<dynamic>? whereArgs,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    final Database db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: where,
      whereArgs: whereArgs,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    );
    return List.generate(maps.length, (index) => fromMap(maps[index]));
  }

  /// Performs a batch insert operation for multiple items into the database table.
  /// This method is more efficient than individual inserts when dealing with multiple records.
  Future<void> batch(List<T> items) async {
    final Database db = await dbHelper.database;
    final Batch batch = db.batch();

    for (var item in items) {
      batch.insert(
        tableName,
        toMap(item),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  /// Performs a batch delete operation to remove multiple items from the database table.
  Future<void> batchDelete(List<T> items) async {
    final Database db = await dbHelper.database;
    final Batch batch = db.batch();

    for (var item in items) {
      batch.delete(
        tableName,
        where: "id = ?",
        whereArgs: [(item as dynamic).id],
      );
    }

    await batch.commit(noResult: true);
  }
}
