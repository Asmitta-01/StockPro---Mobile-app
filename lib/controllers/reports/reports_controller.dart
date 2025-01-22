import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_pro/models/operation_model.dart';
import 'package:stock_pro/repositories/operation_repository.dart';
import 'package:stock_pro/routes.dart';

class ReportsController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final int pagePosition = 6;

  final OperationRepository _operationRepository = Get.find();
  List<OperationModel> _operations = [];

  ReportsController() {
    _loadData();
  }

  void _loadData() async {
    _operations = await _operationRepository.getAll();
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

  final List<double> pieData = const [26, 20, 18, 17, 19];
  final List<String> pieLabels = const [
    "Ciment ROBUST",
    "Fer de 12",
    "Pointe Toc de 30",
    "Ciment DANGOTE",
    "Peinture SMALTO 30Kg"
  ];

  List<double> get lineDataOperationsAmounts =>
      _operations.map((e) => e.amount / 1000).toList();
  List<double> get lineDataOperationsEstimatedAmounts =>
      _operations.map((e) => e.estimatedAmount / 1000).toList();

  List<Color> get pieColors => List.generate(pieData.length,
      (index) => Color(Random().nextInt(0xFFFFFFFF)).withAlpha(0xFF));

  double get data1Average => barData1.reduce((v, e) => v + e) / barData1.length;
  double get data2Average => barData2.reduce((v, e) => v + e) / barData2.length;

  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  void goToStockReportsView() {
    Get.toNamed(Routes.stockReports);
  }
}
