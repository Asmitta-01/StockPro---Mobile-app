import 'package:json_annotation/json_annotation.dart';
import 'package:stock_pro/models/enums/transport_method.dart';

part 'transport_model.g.dart';

@JsonSerializable()
class TransportModel {
  TransportMethod method;
  double cost;

  TransportModel(this.method, this.cost);

  factory TransportModel.fromJson(Map<String, dynamic> json) =>
      _$TransportModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransportModelToJson(this);
}
