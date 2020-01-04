class Category {

  final String id;
  final String imagePath;
  final String title;
  Category({this.id, this.imagePath, this.title});

  factory Category.fromJson(Map<String, dynamic> parsedJson) {
    return Category(
        id: parsedJson['id'],
        imagePath: parsedJson['imagePath'],
        title: parsedJson['title']);
  }
}

class Categories {
  List<Category> categories;
  Categories({this.categories});

  factory Categories.fromJson(List<dynamic> json) {
    return Categories(
        categories: json
            .map((e) => Category.fromJson(e as Map<String, dynamic>))
            .toList());
  }
}