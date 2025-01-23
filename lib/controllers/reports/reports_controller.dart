import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stock_pro/models/enums/operation_type.dart';
import 'package:stock_pro/models/item_model.dart';
import 'package:stock_pro/models/operation_model.dart';
import 'package:stock_pro/repositories/operation_repository.dart';
import 'package:stock_pro/routes.dart';

class ReportsController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final int pagePosition = 6;

  final OperationRepository _operationRepository = Get.find();
  List<OperationModel> _operations = [];
  Map<DateTime, List<OperationModel>> _incomingOperationsByDay = {};
  Map<DateTime, List<OperationModel>> _outgoingOperationsByDay = {};
  Iterable<MapEntry<ItemModel, int>> mostSoldItems = [];

  /// Number of days to look back when calculating recent statistics.
  /// Used as a time window for filtering operations and generating reports.
  final int pastDays = 7;

  ReportsController() {
    _loadData();
  }

  void _loadData() async {
    _operations = await _operationRepository.getAll();
    _loadMostSoldItems();
    _loadIncomingOperations();
    _loadOutgoingOperations();
  }

  /// Groups incoming operations by day within the specified time range.
  ///
  /// Filters operations where type is 'incoming' and created within [pastDays].
  ///  Groups filtered operations by day using [_getOperationsByDay]
  /// 3. Updates [_incomingOperationsByDay] with the grouped results
  void _loadIncomingOperations() {
    DateTime startDate = DateTime.now().subtract(Duration(days: pastDays));
    final incomingOperations = _operations.where((e) {
      var after = e.createdAt.isAfter(startDate);
      return e.type == OperationType.incoming && after;
    }).toList();

    Map<DateTime, List<OperationModel>> operationsByDay =
        _getOperationsByDay(startDate, incomingOperations);
    _incomingOperationsByDay = operationsByDay;
    update();
  }

  void _loadOutgoingOperations() {
    DateTime startDate = DateTime.now().subtract(Duration(days: pastDays));
    final outgoingOperations = _operations.where((e) {
      var after = e.createdAt.isAfter(startDate);
      return e.type == OperationType.outgoing && after;
    }).toList();

    Map<DateTime, List<OperationModel>> operationsByDay =
        _getOperationsByDay(startDate, outgoingOperations);
    _outgoingOperationsByDay = operationsByDay;
    update();
  }

  /// Creates a map of operations grouped by day starting from [startDate].
  ///
  /// Parameters:
  /// - [startDate]: The starting date to begin grouping operations
  /// - [outgoingOperations]: List of operations to be grouped
  ///
  /// Returns a Map where:
  /// - Key: DateTime object truncated to day (no time component)
  /// - Value: List of operations that occurred on that day
  ///
  /// The map includes entries for all days in the [pastDays] range,
  /// even if no operations occurred on a particular day (empty list).
  Map<DateTime, List<OperationModel>> _getOperationsByDay(
      DateTime startDate, List<OperationModel> outgoingOperations) {
    Map<DateTime, List<OperationModel>> operationsByDay =
        <DateTime, List<OperationModel>>{};
    for (var i = 0; i < pastDays; i++) {
      var date = startDate.add(Duration(days: i));
      operationsByDay[DateTime(date.year, date.month, date.day)] = [];
    }

    for (var operation in outgoingOperations) {
      var day = DateTime(
        operation.createdAt.year,
        operation.createdAt.month,
        operation.createdAt.day,
      );
      operationsByDay[day]?.add(operation);
    }
    return operationsByDay;
  }

  /// Calculates and updates the most frequently sold items based on outgoing
  /// operations made on the [pastDays].
  ///
  /// This method:
  /// 1. Filters outgoing operations from the last [pastDays]
  /// 2. Creates a frequency map of items and their total quantities sold
  /// 3. Sorts items by quantity in descending order
  /// 4. Takes the top [limit] items (defaults to 5)
  ///
  /// Parameters:
  ///   [limit] - Optional parameter to specify how many top items to return (default: 5)
  void _loadMostSoldItems({int limit = 5}) {
    var allItems = _operations
        .where((e) =>
            e.type == OperationType.outgoing &&
            e.createdAt
                .isAfter(DateTime.now().subtract(Duration(days: pastDays))))
        .map((e) => e.items)
        .toList();
    Map<ItemModel, int> itemsCount = {};
    for (var items in allItems) {
      for (var item in items.entries) {
        if (itemsCount.containsKey(item.key)) {
          itemsCount[item.key] = itemsCount[item.key]! + item.value;
        } else {
          itemsCount[item.key] = item.value;
        }
      }
    }
    var sortedItems = itemsCount.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    mostSoldItems = sortedItems.take(limit);
    update();
  }

  /// Returns a list of daily total amounts from outgoing operations.
  List<double> get outgoingOperationsAmountsPerDay =>
      _outgoingOperationsByDay.entries.map((e) {
        return e.value.fold<double>(
            0.0, (previousValue, element) => previousValue + element.amount);
      }).toList();

  /// Returns a list of daily total amounts from incoming operations.
  /// Each element represents the sum of all operation amounts for a specific day.
  List<double> get incomingOperationsAmountsPerDay =>
      _incomingOperationsByDay.entries.map((e) {
        return e.value.fold<double>(
            0.0, (previousValue, element) => previousValue + element.amount);
      }).toList();

  /// Returns a list of day names (Mon, Tue, etc.) for the past operations.
  List<String> get pastDaysLabels => _incomingOperationsByDay.entries
      .map(
          (e) => DateFormat.E(Get.locale?.toString()).format(e.key).capitalize!)
      .toList();

  List<String> get mostSoldItemsLabels =>
      mostSoldItems.map((e) => e.key.name).toList();
  List<double> get mostSoldItemsValues =>
      mostSoldItems.map((e) => e.value.toDouble()).toList();
  List<Color> get pieColors => List.generate(mostSoldItems.length,
      (index) => Color(Random().nextInt(0xFFFFFFFF)).withAlpha(0xFF));

  List<double> get lineDataOperationsAmounts =>
      _operations.map((e) => e.amount / 1000).toList();
  List<double> get lineDataOperationsEstimatedAmounts =>
      _operations.map((e) => e.estimatedAmount / 1000).toList();

  double get outgoingOperationsAverage =>
      outgoingOperationsAmountsPerDay.fold(0.0, (v, e) => v + e) /
      _outgoingOperationsByDay.length;
  double get incomingOperationsAverage =>
      incomingOperationsAmountsPerDay.fold(0.0, (v, e) => v + e) /
      _incomingOperationsByDay.length;

  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  void goToStockReportsView() {
    Get.toNamed(Routes.stockReports);
  }
}
