import 'dart:convert';

import 'package:hive/hive.dart';

part 'generated/store_entity.g.dart';

@HiveType(typeId: 2)
class StoreEntity {
  @HiveField(0)
  final String? name;

  StoreEntity({
    this.name,
  });

  StoreEntity copyWith({
    String? name,
  }) =>
      StoreEntity(
        name: name ?? this.name,
      );

  factory StoreEntity.fromRawJson(String str) => StoreEntity.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StoreEntity.fromJson(Map<String, dynamic> json) => StoreEntity(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}
