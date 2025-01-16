import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum TransportMethod {
  car,
  moto,
  tricycle,
  train,
  ship;

  static TransportMethod fromString(String type) {
    switch (type) {
      case 'car':
        return TransportMethod.car;
      case 'ship':
        return TransportMethod.ship;
      case 'tricycle':
        return TransportMethod.tricycle;
      case 'train':
        return TransportMethod.train;
      default:
        return TransportMethod.moto;
    }
  }
}
