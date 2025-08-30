class BgImage {
  String imageType;
  String? assetType;
  String imageUrl;
  double aspectRatio;

  BgImage({
    required this.imageType,
    this.assetType,
    required this.imageUrl,
    required this.aspectRatio,
  });

  factory BgImage.fromJson(Map<String, dynamic> json) => BgImage(
        imageType: json["image_type"] ?? 'external',
        assetType: json["asset_type"],
        imageUrl: json["image_url"] ?? '',
        aspectRatio: json["aspect_ratio"]?.toDouble() ?? 1.0,
      );

  Map<String, dynamic> toJson() => {
        "image_type": imageType,
        "asset_type": assetType,
        "image_url": imageUrl,
        "aspect_ratio": aspectRatio,
      };
}
