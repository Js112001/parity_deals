import 'dart:convert';

import 'package:deals/modules/data/models/deal_model.dart';
import 'package:deals/modules/data/models/event_model.dart';
import 'package:deals/modules/data/models/seo_settings_model.dart';

class StoreApiResponseModel {
  final SeoSettings? seoSettings;
  final List<Deal>? deals;
  final Event? event;
  final int? statusCode;
  final String? message;

  StoreApiResponseModel({
    this.seoSettings,
    this.deals,
    this.event,
    this.statusCode,
    this.message,
  });

  StoreApiResponseModel copyWith({
    SeoSettings? seoSettings,
    List<Deal>? deals,
    Event? event,
    int? statusCode,
    String? message,
  }) =>
      StoreApiResponseModel(
        seoSettings: seoSettings ?? this.seoSettings,
        deals: deals ?? this.deals,
        event: event ?? this.event,
        statusCode: statusCode ?? this.statusCode,
        message: message ?? this.message,
      );

  factory StoreApiResponseModel.fromRawJson(String str) =>
      StoreApiResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StoreApiResponseModel.fromJson(Map<String, dynamic> json) =>
      StoreApiResponseModel(
        seoSettings: json["seo_settings"] == null
            ? null
            : SeoSettings.fromJson(json["seo_settings"]),
        deals: json["deals"] == null
            ? []
            : List<Deal>.from(json["deals"]!.map((x) => Deal.fromJson(x))),
        event: json["event"] == null ? null : Event.fromJson(json["event"]),
        statusCode: json["statusCode"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "seo_settings": seoSettings?.toJson(),
        "deals": deals == null
            ? []
            : List<dynamic>.from(deals!.map((x) => x.toJson())),
        "event": event?.toJson(),
        "statusCode": statusCode,
        "message": message,
      };
}
