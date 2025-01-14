class ShopModel {
  int id;
  String name;
  String? image;
  String? logo;
  String? website;
  String address;
  List<String> categories;
  bool active;
  DateTime createdAt;

  ShopModel({
    required this.id,
    required this.name,
    required this.image,
    this.website,
    required this.address,
    this.active = false,
    required this.logo,
    required this.categories,
    required this.createdAt,
  });
}
