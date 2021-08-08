import 'dart:convert';

class Driver {
  int id;
  String firstName;
  String lastName;
  String phone;
  Driver({
    this.id,
    this.firstName,
    this.lastName,
    this.phone,
  });

  Driver copyWith({
    int id,
    String firstName,
    String lastName,
    String phone,
  }) {
    return Driver(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
    };
  }

  factory Driver.fromMap(map) {
    return Driver(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      phone: map['phone'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Driver.fromJson(source) => Driver.fromMap(source);

  @override
  String toString() {
    return 'Driver(id: $id, firstName: $firstName, lastName: $lastName, phone: $phone)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Driver &&
        other.id == id &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.phone == phone;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        phone.hashCode;
  }
}
