class ShopModel {
  int id;
  String name;
  String image;
  String logo;
  List<String> categories;
  bool active;
  DateTime createdAt;

  ShopModel({
    required this.id,
    required this.name,
    required this.image,
    this.active = false,
    required this.logo,
    required this.categories,
    required this.createdAt,
  });
}
