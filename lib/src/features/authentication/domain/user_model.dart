import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  late String uid;
  late String email;
  late String fullName;
  late String phoneNumber;
  late String address;

  User({
    this.uid = '',
    this.email = '',
    this.fullName = '',
    this.phoneNumber = '',
    this.address = '',
  });

  String? get getUid => uid;
  String? get getEmail => email;
  String? get getFullName => fullName;
  String? get getPhoneNumber => phoneNumber;
  String? get getAddress => address;

  set setUid(String uid) => this.uid = uid;
  set setEmail(String email) => this.email = email;
  set setFullName(String fullName) => this.fullName = fullName;
  set setPhoneNumber(String phoneNumber) => this.phoneNumber = phoneNumber;
  set setAddress(String address) => this.address = address;

  User copyWith({
    String? uid,
    String? email,
    String? fullName,
    String? phoneNumber,
    String? address,
  }) {
    return User(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.uid == uid &&
        other.email == email &&
        other.fullName == fullName &&
        other.phoneNumber == phoneNumber &&
        other.address == address;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        email.hashCode ^
        fullName.hashCode ^
        phoneNumber.hashCode ^
        address.hashCode;
  }

  @override
  String toString() {
    return 'User(uid: $uid, email: $email, fullName: $fullName, phoneNumber: $phoneNumber, address: $address)';
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      //uid: map['uid'],
      email: map['email'],
      fullName: map['fullName'],
      phoneNumber: map['phoneNumber'],
      address: map['address'],
    );
  }

  Map<String, dynamic> toMap() => {
        //'uid': uid,
        'email': email,
        'fullName': fullName,
        'phoneNumber': phoneNumber,
        'address': address,
      };
}
