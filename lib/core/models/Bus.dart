import 'dart:convert';

import 'package:bus/core/models/BusType.dart';

class Bus {
  int id;
  int capacity;
  BusType busType;
  String title;
  String plate;
  Bus({
    this.id,
    this.capacity,
    this.title,
    this.plate,
    this.busType,
  });

  Bus copyWith({
    int id,
    int capacity,
    String title,
    String plate,
  }) {
    return Bus(
      id: id ?? this.id,
      capacity: capacity ?? this.capacity,
      title: title ?? this.title,
      plate: plate ?? this.plate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'capacity': capacity,
      'title': title,
      'plate': plate,
    };
  }

  factory Bus.fromMap(map) {
    return Bus(
      id: map['id'],
      capacity: map['capacity'],
      title: map['title'],
      plate: map['plate'],
      busType: BusType.fromJson(map['bus_type']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Bus.fromJson(source) => Bus.fromMap(source);

  @override
  String toString() {
    return 'Bus(id: $id, capacity: $capacity, title: $title, plate: $plate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Bus &&
        other.id == id &&
        other.capacity == capacity &&
        other.title == title &&
        other.plate == plate;
  }

  @override
  int get hashCode {
    return id.hashCode ^ capacity.hashCode ^ title.hashCode ^ plate.hashCode;
  }
}
