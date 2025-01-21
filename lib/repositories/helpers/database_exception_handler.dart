import 'package:get/get_utils/get_utils.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stock_pro/utils/snack_bar_helper.dart';

class DatabaseExceptionHandler {
  static void handleException(DatabaseException e) {
    String errorMessage = '';

    // Handle different database exceptions
    if (e.isUniqueConstraintError()) {
      errorMessage = 'record_already_exists'.tr;
    } else if (e.isNoSuchTableError()) {
      errorMessage = 'the_requested_table_does_not_exist'.tr;
    } else if (e.isDatabaseClosedError()) {
      errorMessage = 'database_connection_closed'.tr;
    } else if (e.isSyntaxError()) {
      errorMessage = 'invalid_sql_syntax'.tr;
    } else if (e.isNotNullConstraintError()) {
      errorMessage = 'required_field_cannot_be_null'.tr;
    } else {
      errorMessage = '${'database_error_occurred'.tr}: ${e.toString()}';
    }

    // Show snackbar with error message
    SnackbarHelper.showError(errorMessage);
  }
}
