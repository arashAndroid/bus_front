import 'dart:convert';

import 'package:bus/core/models/Travel.dart';

import 'City.dart';

class TravelDetail {
  int id;
  int price;
  int capacity;
  bool status;
  City source;
  City destination;
  String departureDatetime;
  Travel travel;
  TravelDetail({
    this.id,
    this.price,
    this.capacity,
    this.status,
    this.source,
    this.destination,
    this.departureDatetime,
    this.travel,
  });

  TravelDetail copyWith({
    int id,
    int price,
    int capacity,
    bool status,
    City source,
    City destination,
    String departureDatetime,
    Travel travel,
  }) {
    return TravelDetail(
      id: id ?? this.id,
      price: price ?? this.price,
      capacity: capacity ?? this.capacity,
      status: status ?? this.status,
      source: source ?? this.source,
      destination: destination ?? this.destination,
      departureDatetime: departureDatetime ?? this.departureDatetime,
      travel: travel ?? this.travel,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'price': price,
      'capacity': capacity,
      'status': status,
      'source': source.toMap(),
      'destination': destination.toMap(),
      'departureDatetime': departureDatetime,
      'travel': travel.toMap(),
    };
  }

  factory TravelDetail.fromMap(map) {
    return TravelDetail(
      id: map['id'],
      price: map['price'],
      capacity: map['capacity'] ?? 0,
      status: map['status'] == 1,
      source: City.fromMap(map['source']),
      destination: City.fromMap(map['destination']),
      departureDatetime: map['departureDatetime'],
      travel: Travel.fromMap(map['travel']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TravelDetail.fromJson(source) => TravelDetail.fromMap(source);

  @override
  String toString() {
    return 'TravelDetail(id: $id, price: $price, capacity: $capacity, status: $status, source: $source, destination: $destination, departureDatetime: $departureDatetime, travel: $travel)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TravelDetail &&
        other.id == id &&
        other.price == price &&
        other.capacity == capacity &&
        other.status == status &&
        other.source == source &&
        other.destination == destination &&
        other.departureDatetime == departureDatetime &&
        other.travel == travel;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        price.hashCode ^
        capacity.hashCode ^
        status.hashCode ^
        source.hashCode ^
        destination.hashCode ^
        departureDatetime.hashCode ^
        travel.hashCode;
  }
}
