import 'package:json_annotation/json_annotation.dart';
import 'package:stock_pro/models/converters/string_map_converter.dart';
import 'package:stock_pro/models/converters/string_transport_converter.dart';
import 'package:stock_pro/models/enums/operation_type.dart';
import 'package:stock_pro/models/item_model.dart';
import 'package:stock_pro/models/transport_model.dart';

part 'operation_model.g.dart';

/// Represents a stock operation/transaction that tracks items and their quantities.
///
/// An operation contains:
/// * A unique identifier
/// * Creation timestamp
/// * OperationModel type (e.g., incoming, outgoing, etc.)
/// * Actual amount of the transaction
/// * Optional comment for additional context
/// * Collection of items and their quantities involved in the operation
///
/// The class also provides an [estimatedAmount] calculation based on the items' prices
/// and quantities, which can be compared against the actual amount for verification.
@JsonSerializable()
class OperationModel {
  int id;
  DateTime createdAt;
  OperationType type;
  double amount;
  String? comment;
  String? invoiceNumber;

  @StringTransportConverter()
  TransportModel? transport;

  @StringMapConverter()
  Map<ItemModel, int> items = {};

  OperationModel({
    required this.id,
    required this.createdAt,
    required this.type,
    required this.amount,
    this.invoiceNumber,
    this.comment,
    this.transport,
  });

  double get estimatedAmount =>
      items.entries.fold(0, (sum, item) => sum + item.key.price * item.value);

  double get totalAmount => amount + (transport?.cost ?? 0);

  factory OperationModel.fromJson(Map<String, dynamic> json) =>
      _$OperationModelFromJson(json);

  Map<String, dynamic> toJson() => _$OperationModelToJson(this);
}
