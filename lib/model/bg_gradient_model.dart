class BgGradient {
  int angle;
  List<String> colors;

  BgGradient({
    required this.angle,
    required this.colors,
  });

  factory BgGradient.fromJson(Map<String, dynamic> json) => BgGradient(
        angle: json["angle"] ?? 0,
        colors: json["colors"] != null
            ? List<String>.from(json["colors"].map((x) => x))
            : ['#000000'],
      );

  Map<String, dynamic> toJson() => {
        "angle": angle,
        "colors": List<dynamic>.from(colors.map((x) => x)),
      };
}
