import 'dart:convert';

import 'package:bus/core/models/City.dart';

import 'Bus.dart';
import 'Driver.dart';

class Travel {
  int id;
  int price;
  String departureDatetime;
  bool status;
  Driver driver;
  Bus bus;

  Travel({
    this.id,
    this.price,
    this.departureDatetime,
    this.status,
    this.driver,
    this.bus,
  });

  Travel copyWith({
    int id,
    int price,
    String departureDatetime,
    bool status,
    Driver driver,
    Bus bus,
  }) {
    return Travel(
      id: id ?? this.id,
      price: price ?? this.price,
      departureDatetime: departureDatetime ?? this.departureDatetime,
      status: status ?? this.status,
      driver: driver ?? this.driver,
      bus: bus ?? this.bus,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'price': price,
      'departureDatetime': departureDatetime,
      'status': status,
      'driver': driver.toMap(),
      'bus': bus.toMap(),
    };
  }

  factory Travel.fromMap(map) {
    return Travel(
      id: map['id'],
      price: map['price'],
      departureDatetime: map['departureDatetime'],
      status: map['status'] == 1,
      driver: Driver.fromMap(map['driver']),
      bus: Bus.fromMap(map['bus']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Travel.fromJson(source) => Travel.fromMap(source);

  @override
  String toString() {
    return 'Travel(id: $id, price: $price, departureDatetime: $departureDatetime, status: $status, driver: $driver, bus: $bus)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Travel &&
        other.id == id &&
        other.price == price &&
        other.departureDatetime == departureDatetime &&
        other.status == status &&
        other.driver == driver &&
        other.bus == bus;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        price.hashCode ^
        departureDatetime.hashCode ^
        status.hashCode ^
        driver.hashCode ^
        bus.hashCode;
  }
}
