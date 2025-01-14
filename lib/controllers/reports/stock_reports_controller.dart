import 'package:get/get.dart';
import 'package:stock_pro/models/item_model.dart';

class StockReportsController extends GetxController {
  ItemModel? selectedItem;
  List<ItemModel> items = [
    ItemModel(
      id: 1,
      name: 'Clou de diamètre 100',
      price: 100,
      quantity: 10,
      description:
          'Clou provenant des agences de fabrication de fers du pays. Il ne rouille pas.',
    ),
    ItemModel(
      id: 2,
      name: 'Sac de ciment',
      price: 6000,
      quantity: 20,
      description: 'This is item 2',
    ),
    ItemModel(
      id: 3,
      name: 'Barre de fer de diamètre 12',
      price: 3000,
      quantity: 30,
      description: 'This is item 3',
    ),
    ItemModel(
      id: 4,
      name: 'Barre de fer de diamètre 16',
      price: 4000,
      quantity: 40,
      description: 'This is item 4',
    ),
    ItemModel(
      id: 5,
      name: 'Barre de fer de diamètre 20',
      price: 5000,
      quantity: 50,
      description: 'This is item 5',
    ),
    ItemModel(
      id: 6,
      name: 'Barre de fer de diamètre 25',
      price: 6000,
      quantity: 10,
      description: 'This is item 6',
    ),
  ];

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
