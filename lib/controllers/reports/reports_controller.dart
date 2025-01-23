import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  }

  final List<double> barData1 = const [260, 200, 180, 170, 190, 240, 400];
  final List<double> barData2 = const [160, 50, 90, 20, 190, 140, 200];
  final List<String> barLabels = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];

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

  double get data1Average => barData1.reduce((v, e) => v + e) / barData1.length;
  double get data2Average => barData2.reduce((v, e) => v + e) / barData2.length;

  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  void goToStockReportsView() {
    Get.toNamed(Routes.stockReports);
  }
}
