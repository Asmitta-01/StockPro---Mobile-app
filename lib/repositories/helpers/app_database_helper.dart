import 'package:stock_pro/repositories/helpers/database_helper.dart';
import 'package:stock_pro/utils/constants.dart';

class AppDatabaseHelper extends DatabaseHelper {
  static final AppDatabaseHelper instance = AppDatabaseHelper._();

  AppDatabaseHelper._()
      : super(
          databaseName: AppConstants.appDatabaseName,
          version: 1,
          createTableQueries: [
            _createItemsTableQuery,
            _createShopsTableQuery,
          ],
        );

  static String get _createShopsTableQuery {
    return '''
          CREATE TABLE shops(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            image TEXT,
            website TEXT,
            logo TEXT,
            active INTEGER NOT NULL,
            address TEXT NOT NULL,
            categories TEXT NOT NULL,
            created_at TEXT NOT NULL
          )
          ''';
  }

  static String get _createItemsTableQuery {
    return '''
          CREATE TABLE items(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            price REAL NOT NULL,
            image TEXT,
            description TEXT NOT NULL,
            quantity INTEGER NOT NULL,
            created_at TEXT NOT NULL,
            stock_threshold INTEGER
          )
          ''';
  }
}
