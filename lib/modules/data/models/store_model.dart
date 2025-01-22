import 'dart:convert';

class Store {
  final String? name;

  Store({
    this.name,
  });

  Store copyWith({
    String? name,
  }) =>
      Store(
        name: name ?? this.name,
      );

  factory Store.fromRawJson(String str) => Store.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
