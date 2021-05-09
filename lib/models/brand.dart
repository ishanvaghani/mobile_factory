import 'dart:convert';

import 'package:flutter/material.dart';

class Brand {
  String name;
  String imgUrl;
  String id;
  Brand({
    @required this.name,
    @required this.imgUrl,
    @required this.id,
  });

  Brand copyWith({
    String name,
    String imgUrl,
    String id,
  }) {
    return Brand(
      name: name ?? this.name,
      imgUrl: imgUrl ?? this.imgUrl,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imgUrl': imgUrl,
      'id': id,
    };
  }

  factory Brand.fromMap(Map<String, dynamic> map) {
    return Brand(
      name: map['name'],
      imgUrl: map['imgUrl'],
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Brand.fromJson(String source) => Brand.fromMap(json.decode(source));

  @override
  String toString() => 'Brand(name: $name, imgUrl: $imgUrl, id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Brand &&
        other.name == name &&
        other.imgUrl == imgUrl &&
        other.id == id;
  }

  @override
  int get hashCode => name.hashCode ^ imgUrl.hashCode ^ id.hashCode;
}
