class Styles {
  final List<Style> styles;

  Styles(this.styles);

  factory Styles.fromJson(Map<String, dynamic> json) {
    Iterable styles = json['styles'];
    return Styles(new List<Style>.from(
      styles.map((style) => Style.fromJson(style)).toList(),
    ));
  }
}

class Style {
  final int id;
  final String name;

  Style(this.id, this.name);

  factory Style.fromJson(Map<String, dynamic> json) {
    return Style(json['id'], json['name']);
  }
}
