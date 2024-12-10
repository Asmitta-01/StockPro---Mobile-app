class Item {
  int? id;
  String name;
  String price;
  String? image;
  String description;
  int quantity;

  Item({
    this.id,
    required this.name,
    required this.price,
    this.image,
    required this.description,
    required this.quantity,
  });
}
