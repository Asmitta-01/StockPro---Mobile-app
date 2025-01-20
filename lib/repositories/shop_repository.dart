import 'package:stock_pro/models/shop_model.dart';
import 'package:stock_pro/repositories/base_repository.dart';

class ShopRepository extends BaseRepository<ShopModel> {
  ShopRepository({required super.dbHelper}) : super(tableName: 'shops');

  @override
  ShopModel fromMap(Map<String, dynamic> map) => ShopModel.fromJson(map);

  @override
  Map<String, dynamic> toMap(ShopModel item) => item.toJson();
}
