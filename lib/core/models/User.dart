import 'dart:convert';

class User {
  String username;
  int id;
  String email;
  int cash;
  User({
    this.username,
    this.id,
    this.email,
    this.cash,
  });

  User copyWith({
    String username,
    int id,
    String email,
    int cash,
  }) {
    return User(
      username: username ?? this.username,
      id: id ?? this.id,
      email: email ?? this.email,
      cash: cash ?? this.cash,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'id': id,
      'email': email,
      'cash': cash,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'],
      id: map['id'],
      email: map['email'],
      cash: map['cash'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(username: $username, id: $id, email: $email, cash: $cash)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.username == username &&
        other.id == id &&
        other.email == email &&
        other.cash == cash;
  }

  @override
  int get hashCode {
    return username.hashCode ^ id.hashCode ^ email.hashCode ^ cash.hashCode;
  }
}
