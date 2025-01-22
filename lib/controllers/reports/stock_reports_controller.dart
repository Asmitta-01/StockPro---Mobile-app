import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stock_pro/models/item_model.dart';
import 'package:stock_pro/repositories/item_repository.dart';

class StockReportsController extends GetxController {
  final ItemRepository _itemRepository = Get.find();

  ItemModel? selectedItem;
  List<ItemModel> items = [];

  StockReportsController() {
    _loadItems();
  }

  Future<void> _loadItems() async {
    items = await _itemRepository.getAll().catchError((_) {
      return <ItemModel>[];
    });
    items.sort((a, b) => a.name.compareTo(b.name));
    update();
  }

  int get totalItemsQuantity => items.fold(
      0, (previousValue, element) => previousValue + element.quantity);
  double get totalItemsPrice => items.fold(
      0,
      (previousValue, element) =>
          previousValue + element.price * element.quantity);

  void selectItem(ItemModel? item) {
    selectedItem = item;
    update();
    Get.back();
  }

  Future<void> exportToExcel() async {
    // Create excel file
    var excel = Excel.createExcel();
    var sheet = excel['Sheet1'];

    // Add headers
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0)).value =
        TextCellValue('item_name'.tr);
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0)).value =
        TextCellValue('quantity'.tr);
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0)).value =
        TextCellValue('unit_price'.tr);
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0)).value =
        TextCellValue("estimated_value".tr);

    // Add data rows
    for (var i = 0; i < items.length; i++) {
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1))
          .value = TextCellValue(items[i].name);
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i + 1))
          .value = IntCellValue(items[i].quantity);
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i + 1))
          .value = DoubleCellValue(items[i].price);
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i + 1))
          .value = DoubleCellValue(items[i].price * items[i].quantity);
    }

    // Add totals row
    final lastRow = items.length + 2;
    sheet
        .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: lastRow))
        .value = TextCellValue('total'.tr);
    sheet
        .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: lastRow))
        .value = IntCellValue(totalItemsQuantity);
    sheet
        .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: lastRow))
        .value = DoubleCellValue(totalItemsPrice);

    var fileBytes = excel.save();

    // Save file
    final fileName =
        '${'stock_reports'.tr}_${DateTime.now().millisecondsSinceEpoch}.xlsx';
    final directory = await getApplicationDocumentsDirectory();
    final String path = '${directory.path}/stock_report.xlsx';
    final xFile = XFile.fromData(
      Uint8List.fromList(fileBytes!),
      name: fileName,
      // path: path,
    )..saveTo(path);

    // Share file
    await Share.shareXFiles(
      [xFile],
      subject: 'stock_reports'.tr,
      fileNameOverrides: [fileName],
    );
  }
}
