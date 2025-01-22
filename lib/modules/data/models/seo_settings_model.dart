import 'dart:convert';

class SeoSettings {
  final String? seoTitle;
  final String? seoDescription;
  final String? webUrl;

  SeoSettings({
    this.seoTitle,
    this.seoDescription,
    this.webUrl,
  });

  SeoSettings copyWith({
    String? seoTitle,
    String? seoDescription,
    String? webUrl,
  }) =>
      SeoSettings(
        seoTitle: seoTitle ?? this.seoTitle,
        seoDescription: seoDescription ?? this.seoDescription,
        webUrl: webUrl ?? this.webUrl,
      );

  factory SeoSettings.fromRawJson(String str) =>
      SeoSettings.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SeoSettings.fromJson(Map<String, dynamic> json) => SeoSettings(
        seoTitle: json["seo_title"],
        seoDescription: json["seo_description"],
        webUrl: json["web_url"],
      );

  Map<String, dynamic> toJson() => {
        "seo_title": seoTitle,
        "seo_description": seoDescription,
        "web_url": webUrl,
      };
}
