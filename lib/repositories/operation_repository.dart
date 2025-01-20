import 'package:stock_pro/models/operation_model.dart';
import 'package:stock_pro/repositories/base_repository.dart';

class OperationRepository extends BaseRepository<OperationModel> {
  OperationRepository({required super.dbHelper})
      : super(tableName: 'operations');

  @override
  OperationModel fromMap(Map<String, dynamic> map) =>
      OperationModel.fromJson(map);

  @override
  Map<String, dynamic> toMap(OperationModel item) => item.toJson();
}
