import 'dart:convert';

import 'package:deals/modules/data/models/store_model.dart';

class Deal {
  final int? id;
  final int? commentsCount;
  final DateTime? createdAt;
  final int? createdAtInMillis;
  final String? imageMedium;
  final Store? store;
  final int? statusCode;
  final String? message;

  Deal({
    this.id,
    this.commentsCount,
    this.createdAt,
    this.createdAtInMillis,
    this.imageMedium,
    this.store,
    this.statusCode,
    this.message,
  });

  Deal copyWith({
    int? id,
    int? commentsCount,
    DateTime? createdAt,
    int? createdAtInMillis,
    String? imageMedium,
    Store? store,
    int? statusCode,
    String? message,
  }) =>
      Deal(
        id: id ?? this.id,
        commentsCount: commentsCount ?? this.commentsCount,
        createdAt: createdAt ?? this.createdAt,
        createdAtInMillis: createdAtInMillis ?? this.createdAtInMillis,
        imageMedium: imageMedium ?? this.imageMedium,
        store: store ?? this.store,
        statusCode: statusCode ?? this.statusCode,
        message: message ?? this.message,
      );

  factory Deal.fromRawJson(String str) => Deal.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Deal.fromJson(Map<String, dynamic> json) => Deal(
        id: json["id"],
        commentsCount: json["comments_count"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        createdAtInMillis: json["created_at_in_millis"],
        imageMedium: json["image_medium"],
        store: json["store"] == null ? null : Store.fromJson(json["store"]),
        statusCode: json["statusCode"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "comments_count": commentsCount,
        "created_at": createdAt?.toIso8601String(),
        "created_at_in_millis": createdAtInMillis,
        "image_medium": imageMedium,
        "store": store?.toJson(),
        "statusCode": statusCode,
        "message": message,
      };
}
