import 'dart:convert';

class BusType {
  int id;
  String title;
  BusType({
    this.id,
    this.title,
  });

  BusType copyWith({
    int id,
    String title,
  }) {
    return BusType(
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

  factory BusType.fromMap(map) {
    return BusType(
      id: map['id'],
      title: map['title'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BusType.fromJson(source) => BusType.fromMap(source);

  @override
  String toString() => 'BusType(id: $id, title: $title)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BusType && other.id == id && other.title == title;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode;
}
