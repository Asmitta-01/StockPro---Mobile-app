import 'package:stock_pro/models/item_model.dart';
import 'package:stock_pro/repositories/base_repository.dart';

class ItemRepository extends BaseRepository<ItemModel> {
  ItemRepository({required super.dbHelper}) : super(tableName: 'items');

  @override
  Map<String, dynamic> toMap(ItemModel item) => item.toJson();

  @override
  ItemModel fromMap(Map<String, dynamic> map) => ItemModel.fromJson(map);
}
