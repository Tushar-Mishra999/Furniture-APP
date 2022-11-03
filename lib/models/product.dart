class Product {
  final String id;
  final int price;
  final String title, description, category;
  final List<dynamic> imageList;

  Product(
      {required this.id,
      required this.price,
      required this.title,
      required this.category,
      required this.description,
      required this.imageList});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["_id"],
      price: json["price"],
      title: json["title"],
      imageList: json["imageList"],
      category: json["category"],
      description: json["description"],
    );
  }
}

// List<Product> products = [
//   Product(
//     id: 1,
//     price: 56,
//     title: "Classic Leather Arm Chair",
//     category: "asadasd",
//     imageList:[ "assets/images/Item_1.png"],
//     description:
//         "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim",
//   ),
//   Product(
//     id: 4,
//     price: 68,
//     category: "asdas sdasd",
//     title: "Poppy Plastic Tub Chair",
//     imageList:[ "assets/images/Item_2.png"],
//     description:
//         "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim",
//   ),
//   Product(
//     id: 9,
//     price: 39,
//     category: "asda ads",
//     title: "Bar Stool Chair",
//     imageList:[ "assets/images/Item_3.png"],
//     description:
//         "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim",
//   ),
// ];