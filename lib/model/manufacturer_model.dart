class Manufacturer {
  final String id;
  final String imagePath;
  final String name;
  final String locationName;
  final int rating;
  final bool underPromotion;

  Manufacturer(
      {this.id,
      this.imagePath,
      this.name,
      this.locationName,
      this.rating,
      this.underPromotion});

  factory Manufacturer.fromJson(Map<String, dynamic> parsedJson) {
    return Manufacturer(
        id: parsedJson['id'],
        imagePath: parsedJson['imagePath'],
        name: parsedJson['name'],
        locationName: parsedJson['locationName'],
        rating: int.parse(parsedJson['rating']),
        underPromotion: parsedJson['underPromotion'].toLowerCase() == 'true');
  }
}

class ManufacturerList {
  List<Manufacturer> manufacturerList;
  List<Manufacturer> promotionalManufacturerList;

  ManufacturerList({this.manufacturerList});

  factory ManufacturerList.fromJson(List<dynamic> json) {
    ManufacturerList list = ManufacturerList(
        manufacturerList: json
            .map((e) => Manufacturer.fromJson(e as Map<String, dynamic>))
            .toList());
    list.promotionalManufacturerList = list.manufacturerList
        .where((manufacturer) => manufacturer.underPromotion)
        .toList();
    return list;
  }
}
