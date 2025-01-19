import 'package:stock_pro/repositories/helpers/database_helper.dart';
import 'package:stock_pro/utils/constants.dart';

class AppDatabaseHelper extends DatabaseHelper {
  static final AppDatabaseHelper instance = AppDatabaseHelper._();

  AppDatabaseHelper._()
      : super(
          databaseName: AppConstants.appDatabaseName,
          version: 1,
          createTableQueries: [
            '''
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
            ''',
            // Add more table creation queries here
          ],
        );
}
