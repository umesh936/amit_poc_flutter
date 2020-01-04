class Product {
  final String id;
  final String imagePath;
  final String name;
  final String manufactureCount;

  Product({this.id, this.imagePath, this.name, this.manufactureCount});

  factory Product.fromJson(Map<String, dynamic> parsedJson) {
    return Product(
      id: parsedJson['id'],
      imagePath: parsedJson['imagePath'],
      name: parsedJson['name'],
      manufactureCount: parsedJson['manufactureCount'],
    );
  }
}

class Products {
  List<Product> products;

  Products({this.products});

  factory Products.fromJson(List<dynamic> json) {
    return Products(
        products: json
            .map((e) => Product.fromJson(e as Map<String, dynamic>))
            .toList());
  }
}
