class Layout {
  final String image;
  final String link;
  final List<String> categories; // <-- NEW FIELD

  Layout({
    required this.image,
    required this.link,
    required this.categories,
  });

  factory Layout.fromJson(Map<String, dynamic> json) {
    return Layout(
      image: json['image'],
      link: json['link'],
      categories: List<String>.from(json['categories'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'link': link,
      'categories': categories,
    };
  }
}

class BuilderModel {
  final String title;
  final String image;
  final String baseNumber;
  final List<Layout> layouts;

  BuilderModel({
    required this.title,
    required this.image,
    required this.baseNumber,
    required this.layouts,
  });

  factory BuilderModel.fromJson(Map<String, dynamic> json) {
    var layoutList =
        (json['layouts'] as List).map((i) => Layout.fromJson(i)).toList();

    return BuilderModel(
      title: json['title'],
      image: json['image'],
      baseNumber: json['baseNumber'],
      layouts: layoutList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'image': image,
      'baseNumber': baseNumber,
      'layouts': layouts.map((e) => e.toJson()).toList(),
    };
  }
}
