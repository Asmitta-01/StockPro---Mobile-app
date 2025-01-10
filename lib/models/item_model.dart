class ItemModel {
  int? id;
  String name;
  double price;
  String? image;
  String description;
  int quantity;

  int? _stockThreshold;

  int get stockThreshold => _stockThreshold!;

  set stockThreshold(int value) {
    _stockThreshold = value;
  }

  ItemModel({
    this.id,
    required this.name,
    required this.price,
    this.image,
    required this.description,
    required this.quantity,
  });
}
