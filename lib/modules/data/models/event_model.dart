import 'dart:convert';

class Event {
  final int? id;
  final String? imageUrl;
  final String? pageUrl;

  Event({
    this.id,
    this.imageUrl,
    this.pageUrl,
  });

  Event copyWith({
    int? id,
    String? imageUrl,
    String? pageUrl,
  }) =>
      Event(
        id: id ?? this.id,
        imageUrl: imageUrl ?? this.imageUrl,
        pageUrl: pageUrl ?? this.pageUrl,
      );

  factory Event.fromRawJson(String str) => Event.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["id"],
        imageUrl: json["image_url"],
        pageUrl: json["page_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image_url": imageUrl,
        "page_url": pageUrl,
      };
}
