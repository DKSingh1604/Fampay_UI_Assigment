import 'package:fampay_assignment/model/card_model.dart';

class HcGroup {
  int id;
  String name;
  String designType;
  int cardType;
  List<Card> cards;
  bool isScrollable;
  int? height;
  bool isFullWidth;
  String? slug;
  int level;

  HcGroup({
    required this.id,
    required this.name,
    required this.designType,
    required this.cardType,
    required this.cards,
    required this.isScrollable,
    this.height,
    required this.isFullWidth,
    this.slug,
    required this.level,
  });

  factory HcGroup.fromJson(Map<String, dynamic> json) => HcGroup(
        id: json["id"] ?? 0,
        name: json["name"] ?? "", 
        designType: json["design_type"] ?? "", 
        cardType: json["card_type"] ?? 0, 
        cards: json["cards"] != null
            ? List<Card>.from(json["cards"].map((x) => Card.fromJson(x)))
            : [], 
        isScrollable:
            json["is_scrollable"] ?? false, 
        height: json["height"], 
        isFullWidth:
            json["is_full_width"] ?? false, 
        slug: json["slug"] ?? "", 
        level: json["level"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "design_type": designType,
        "card_type": cardType,
        "cards": List<dynamic>.from(cards.map((x) => x.toJson())),
        "is_scrollable": isScrollable,
        "height": height,
        "is_full_width": isFullWidth,
        "slug": slug,
        "level": level,
      };
}
