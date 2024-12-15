import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_pro/models/enums/operation_type.dart';
import 'package:stock_pro/models/enums/transport_method.dart';
import 'package:stock_pro/models/operation.dart';
import 'package:stock_pro/models/transport.dart';
import 'package:stock_pro/routes.dart';

class OperationsController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final int pagePosition = 3;

  List<Operation> operations = [
    Operation(
      id: 1,
      createdAt: DateTime.now(),
      type: OperationType.incoming,
      amount: 34000,
      invoiceNumber: "ST0001",
      transport: Transport(TransportMethod.tricycle, 1000),
    ),
    Operation(
      id: 2,
      createdAt: DateTime.now(),
      type: OperationType.outgoing,
      amount: 3000,
      invoiceNumber: "ST0002",
    ),
    Operation(
      id: 3,
      createdAt: DateTime.now(),
      type: OperationType.incoming,
      amount: 61000,
      invoiceNumber: "ST0003",
      transport: Transport(TransportMethod.tricycle, 1500),
    ),
    Operation(
      id: 4,
      createdAt: DateTime.now(),
      type: OperationType.outgoing,
      amount: 9000,
      invoiceNumber: "ST0004",
      transport: Transport(TransportMethod.moto, 500),
    ),
    Operation(
      id: 5,
      createdAt: DateTime.now(),
      type: OperationType.outgoing,
      amount: 140000,
      invoiceNumber: "ST0005",
      transport: Transport(TransportMethod.car, 5000),
    ),
    Operation(
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
