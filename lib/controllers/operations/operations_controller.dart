import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_pro/models/enums/operation_type.dart';
import 'package:stock_pro/models/enums/transport_method.dart';
import 'package:stock_pro/models/operation_model.dart';
import 'package:stock_pro/models/transport_model.dart';
import 'package:stock_pro/routes.dart';

class OperationsController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final int pagePosition = 3;

  List<OperationModel> operations = [
    OperationModel(
      id: 1,
      createdAt: DateTime.now(),
      type: OperationType.incoming,
      amount: 34000,
      invoiceNumber: "ST0001",
      transport: TransportModel(TransportMethod.tricycle, 1000),
    ),
    OperationModel(
      id: 2,
      createdAt: DateTime.now(),
      type: OperationType.outgoing,
      amount: 3000,
      invoiceNumber: "ST0002",
    ),
    OperationModel(
      id: 3,
      createdAt: DateTime.now(),
      type: OperationType.incoming,
      amount: 61000,
      invoiceNumber: "ST0003",
      transport: TransportModel(TransportMethod.tricycle, 1500),
    ),
    OperationModel(
      id: 4,
      createdAt: DateTime.now(),
      type: OperationType.outgoing,
      amount: 9000,
      invoiceNumber: "ST0004",
      transport: TransportModel(TransportMethod.moto, 500),
    ),
    OperationModel(
      id: 5,
      createdAt: DateTime.now(),
      type: OperationType.outgoing,
      amount: 140000,
      invoiceNumber: "ST0005",
      transport: TransportModel(TransportMethod.car, 5000),
    ),
    OperationModel(
      id: 6,
      createdAt: DateTime.now(),
      type: OperationType.transfer,
      amount: 90000,
      invoiceNumber: "ST0006",
    ),
  ];

  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  void goToAddOperationScreen() {
    Get.toNamed(Routes.addOperation);
  }
}
