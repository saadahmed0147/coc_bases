class TownhallModel {
  final String title;
  final String image;
  final String baseNumber;
  final List<LayoutModel> layouts;

  TownhallModel({
    required this.title,
    required this.image,
    required this.baseNumber,
    required this.layouts,
  });

  factory TownhallModel.fromMap(Map<String, dynamic> map) {
    return TownhallModel(
      title: map['title'],
      image: map['image'],
      baseNumber: map['baseNumber'],
      layouts: (map['layouts'] as List)
          .map((layout) => LayoutModel.fromMap(layout))
          .toList(),
    );
  }
}

class LayoutModel {
  final String image;
  final String link;
  final List<String> categories;

  LayoutModel({
    required this.image,
    required this.link,
    required this.categories,
  });

  factory LayoutModel.fromMap(Map<String, dynamic> map) {
    return LayoutModel(
      image: map['image'],
      link: map['link'],
      categories: List<String>.from(map['categories']),
    );
  }
}
