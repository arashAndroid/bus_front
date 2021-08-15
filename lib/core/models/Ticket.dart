import 'dart:convert';

import 'package:bus/core/models/TravelDetail.dart';

import 'User.dart';

class Ticket {
  int id;
  String qrCode;
  String createdAt;
  User user;
  TravelDetail travelDetail;
  Ticket({
    this.id,
    this.qrCode,
    this.createdAt,
    this.user,
    this.travelDetail,
  });

  Ticket copyWith({
    int id,
    String qrCode,
    String createdAt,
    User user,
    TravelDetail travelDetail,
  }) {
    return Ticket(
      id: id ?? this.id,
      qrCode: qrCode ?? this.qrCode,
      createdAt: createdAt ?? this.createdAt,
      user: user ?? this.user,
      travelDetail: travelDetail ?? this.travelDetail,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'qrCode': qrCode,
      'createdAt': createdAt,
      'user': user.toMap(),
      'travelDetail': travelDetail.toMap(),
    };
  }

  factory Ticket.fromMap(map) {
    return Ticket(
      id: map['id'],
      qrCode: map['qrCode'],
      createdAt: map['createdAt'],
      user: User.fromMap(map['user']),
      travelDetail: TravelDetail.fromMap(map['travelDetail']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Ticket.fromJson(source) => Ticket.fromMap(source);

  @override
  String toString() {
    return 'Ticket(id: $id, qrCode: $qrCode, createdAt: $createdAt, user: $user, travel: $travelDetail)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Ticket &&
        other.id == id &&
        other.qrCode == qrCode &&
        other.createdAt == createdAt &&
        other.user == user &&
        other.travelDetail == travelDetail;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        qrCode.hashCode ^
        createdAt.hashCode ^
        user.hashCode ^
        travelDetail.hashCode;
  }
}
