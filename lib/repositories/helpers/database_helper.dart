import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class DatabaseHelper {
  static Database? _database;
  final String databaseName;
  final int version;
  final List<String> createTableQueries;

  DatabaseHelper({
    required this.databaseName,
    required this.version,
    required this.createTableQueries,
  });

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), databaseName);
    return await openDatabase(
      path,
      version: version,
      onCreate: (Database db, int version) async {
        for (String query in createTableQueries) {
          await db.execute(query);
        }
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        // Handle database upgrades here
      },
    );
  }
}
