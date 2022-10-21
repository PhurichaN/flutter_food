class FoodItem {
  final int id;
  final String name;
  final int price;
  final String image;

  FoodItem({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      image: json['image'],
    );
  }

  // named constructor
  FoodItem.fromJson2(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        price = json['price'],
        image = json['image'];

}
