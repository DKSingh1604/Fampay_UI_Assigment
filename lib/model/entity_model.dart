class Entity {
  String? text;
  String type;
  String? color;
  String? url;
  String fontStyle;
  String fontFamily;
  int? fontSize;

  Entity({
    this.text,
    required this.type,
    this.color,
    this.url,
    required this.fontStyle,
    required this.fontFamily,
    this.fontSize,
  });

  factory Entity.fromJson(Map<String, dynamic> json) => Entity(
        text: json["text"] ?? '',
        type: json["type"] ?? 'text',
        color: json["color"] ?? '#000000',
        url: json["url"],
        fontStyle: json["font_style"] ?? 'normal',
        fontFamily: json["font_family"] ?? 'Arial',
        fontSize: json["font_size"] ?? 14,
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "type": type,
        "color": color,
        "url": url,
        "font_style": fontStyle,
        "font_family": fontFamily,
        "font_size": fontSize,
      };
}
