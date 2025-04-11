class Layout {
  final String image;
  final String link;
  final List<String> categories;

  Layout({
    required this.image,
    required this.link,
    required this.categories,
  });

  factory Layout.fromMap(Map<String, dynamic> map) {
    return Layout(
      image: map['image'],
      link: map['link'],
      categories: List<String>.from(map['categories']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'link': link,
      'categories': categories,
    };
  }
}

class TownHall {
  final String title;
  final String image;
  final String baseNumber;
  final List<Layout> layouts;

  TownHall({
    required this.title,
    required this.image,
    required this.baseNumber,
    required this.layouts,
  });

  factory TownHall.fromMap(Map<String, dynamic> map) {
    return TownHall(
      title: map['title'],
      image: map['image'],
      baseNumber: map['baseNumber'],
      layouts: (map['layouts'] as List)
          .map((layout) => Layout.fromMap(layout))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'image': image,
      'baseNumber': baseNumber,
      'layouts': layouts.map((layout) => layout.toMap()).toList(),
    };
  }
}
