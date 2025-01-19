import 'package:get/get.dart';
import 'package:stock_pro/models/item_model.dart';

class StockReportsController extends GetxController {
  ItemModel? selectedItem;
  List<ItemModel> items = [];

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
}
