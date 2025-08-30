import 'dart:convert';

import 'package:fampay_assignment/model/hc_group_model.dart';

List<ApiData> apiDataFromJson(String str) =>
    List<ApiData>.from(json.decode(str).map((x) => ApiData.fromJson(x)));

String apiDataToJson(List<ApiData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ApiData {
  int id;
  String slug;
  dynamic title;
  dynamic formattedTitle;
  dynamic description;
  dynamic formattedDescription;
  dynamic assets;
  List<HcGroup> hcGroups;

  ApiData({
    required this.id,
    required this.slug,
    required this.title,
    required this.formattedTitle,
    required this.description,
    required this.formattedDescription,
    required this.assets,
    required this.hcGroups,
  });

  factory ApiData.fromJson(Map<String, dynamic> json) => ApiData(
        id: json["id"] ?? 0, 
        slug: json["slug"] ?? "", 
        title: json["title"] ?? "", 
        formattedTitle:
            json["formatted_title"] ?? "", 
        description: json["description"] ?? "",
        formattedDescription: json["formatted_description"] ?? "",
        assets: json["assets"] ?? "",
        hcGroups: json["hc_groups"] != null
            ? List<HcGroup>.from(
                json["hc_groups"].map((x) => HcGroup.fromJson(x)))
            : [], 
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "title": title,
        "formatted_title": formattedTitle,
        "description": description,
        "formatted_description": formattedDescription,
        "assets": assets,
        "hc_groups": List<dynamic>.from(hcGroups.map((x) => x.toJson())),
      };
}