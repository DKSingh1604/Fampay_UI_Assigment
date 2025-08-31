import 'package:fampay_assignment/model/entity_model.dart';

class Formatted {
  String text;
  String align;
  List<Entity> entities;

  Formatted({
    required this.text,
    required this.align,
    required this.entities,
  });

  factory Formatted.fromJson(Map<String, dynamic> json) => Formatted(
        text: json["text"] ?? '',
        align: json["align"] ?? 'left',
        entities: json["entities"] != null
            ? List<Entity>.from(
                json["entities"].map(
                  (x) => Entity.fromJson(x),
                ),
              )
            : [],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "align": align,
        "entities": List<dynamic>.from(entities.map((x) => x.toJson())),
      };
}
