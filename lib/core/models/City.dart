import 'dart:convert';

class City {
  int id;
  String title;
  City({
    this.id,
    this.title,
  });

  City copyWith({
    int id,
    String title,
  }) {
    return City(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
    };
  }

  factory City.fromMap(map) {
    return City(
      id: map['id'],
      title: map['title'],
    );
  }

  String toJson() => json.encode(toMap());

  factory City.fromJson(source) => City.fromMap(source);

  @override
  String toString() => 'City(id: $id, title: $title)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is City && other.id == id && other.title == title;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode;
}
