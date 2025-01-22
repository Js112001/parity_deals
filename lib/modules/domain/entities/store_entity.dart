import 'dart:convert';

class StoreEntity {
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
