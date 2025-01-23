import 'dart:convert';

import 'package:deals/modules/data/models/deal_model.dart';
import 'package:deals/modules/domain/entities/store_entity.dart';
import 'package:hive/hive.dart';

part 'generated/deal_entity.g.dart';

@HiveType(typeId: 1)
class DealEntity {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final int? commentsCount;
  @HiveField(2)
  final DateTime? createdAt;
  @HiveField(3)
  final int? createdAtInMillis;
  @HiveField(4)
  final String? imageMedium;
  @HiveField(5)
  final StoreEntity? store;
  @HiveField(6)
  final int? statusCode;
  @HiveField(7)
  final String? message;

  DealEntity({
    this.id,
    this.commentsCount,
    this.createdAt,
    this.createdAtInMillis,
    this.imageMedium,
    this.store,
    this.statusCode,
    this.message,
  });

  DealEntity copyWith({
    int? id,
    int? commentsCount,
    DateTime? createdAt,
    int? createdAtInMillis,
    String? imageMedium,
    StoreEntity? store,
    int? statusCode,
    String? message,
  }) =>
      DealEntity(
        id: id ?? this.id,
        commentsCount: commentsCount ?? this.commentsCount,
        createdAt: createdAt ?? this.createdAt,
        createdAtInMillis: createdAtInMillis ?? this.createdAtInMillis,
        imageMedium: imageMedium ?? this.imageMedium,
        store: store ?? this.store,
        statusCode: statusCode ?? this.statusCode,
        message: message ?? this.message,
      );

  factory DealEntity.fromRawJson(String str) =>
      DealEntity.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DealEntity.fromJson(Map<String, dynamic> json) => DealEntity(
        id: json["id"],
        commentsCount: json["comments_count"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        createdAtInMillis: json["created_at_in_millis"],
        imageMedium: json["image_medium"],
        store:
            json["store"] == null ? null : StoreEntity.fromJson(json["store"]),
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

  static DealEntity toEntity(Deal deal) => DealEntity(
        id: deal.id,
        commentsCount: deal.commentsCount,
        createdAt: deal.createdAt,
        createdAtInMillis: deal.createdAtInMillis,
        imageMedium: deal.imageMedium,
        store: StoreEntity.fromJson(
          deal.store?.toJson() ?? {},
        ),
        statusCode: deal.statusCode,
        message: deal.message,
      );
}
