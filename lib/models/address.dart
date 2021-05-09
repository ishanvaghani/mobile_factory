import 'dart:convert';

import 'package:flutter/material.dart';

class Address {
  String id;
  String firstName;
  String lastName;
  String address1;
  String address2;
  String city;
  String state;
  String zipcode;
  String country;
  Address({
    @required this.id,
    @required this.firstName,
    @required this.lastName,
    @required this.address1,
    @required this.address2,
    @required this.city,
    @required this.state,
    @required this.zipcode,
    @required this.country,
  });
  

  Address copyWith({
    String id,
    String firstName,
    String lastName,
    String address1,
    String address2,
    String city,
    String state,
    String zipcode,
    String country,
  }) {
    return Address(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
      city: city ?? this.city,
      state: state ?? this.state,
      zipcode: zipcode ?? this.zipcode,
      country: country ?? this.country,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'address1': address1,
      'address2': address2,
      'city': city,
      'state': state,
      'zipcode': zipcode,
      'country': country,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      address1: map['address1'],
      address2: map['address2'],
      city: map['city'],
      state: map['state'],
      zipcode: map['zipcode'],
      country: map['country'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) => Address.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Address(id: $id, firstName: $firstName, lastName: $lastName, address1: $address1, address2: $address2, city: $city, state: $state, zipcode: $zipcode, country: $country)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Address &&
      other.id == id &&
      other.firstName == firstName &&
      other.lastName == lastName &&
      other.address1 == address1 &&
      other.address2 == address2 &&
      other.city == city &&
      other.state == state &&
      other.zipcode == zipcode &&
      other.country == country;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      address1.hashCode ^
      address2.hashCode ^
      city.hashCode ^
      state.hashCode ^
      zipcode.hashCode ^
      country.hashCode;
  }
}
