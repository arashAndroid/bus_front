import 'dart:convert';

import 'Travel.dart';
import 'User.dart';

class Ticket {
  int id;
  String qrCode;
  String createdAt;
  User user;
  Travel travel;
  Ticket({
    this.id,
    this.qrCode,
    this.createdAt,
    this.user,
    this.travel,
  });

  Ticket copyWith({
    int id,
    String qrCode,
    String createdAt,
    User user,
    Travel travel,
  }) {
    return Ticket(
      id: id ?? this.id,
      qrCode: qrCode ?? this.qrCode,
      createdAt: createdAt ?? this.createdAt,
      user: user ?? this.user,
      travel: travel ?? this.travel,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'qrCode': qrCode,
      'createdAt': createdAt,
      'user': user.toMap(),
      'travel': travel.toMap(),
    };
  }

  factory Ticket.fromMap(map) {
    return Ticket(
      id: map['id'],
      qrCode: map['qrCode'],
      createdAt: map['createdAt'],
      user: User.fromMap(map['user']),
      travel: Travel.fromMap(map['travel']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Ticket.fromJson(source) => Ticket.fromMap(source);

  @override
  String toString() {
    return 'Ticket(id: $id, qrCode: $qrCode, createdAt: $createdAt, user: $user, travel: $travel)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Ticket &&
        other.id == id &&
        other.qrCode == qrCode &&
        other.createdAt == createdAt &&
        other.user == user &&
        other.travel == travel;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        qrCode.hashCode ^
        createdAt.hashCode ^
        user.hashCode ^
        travel.hashCode;
  }
}
