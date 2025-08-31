import 'package:flutter/material.dart';
import 'package:fampay_assignment/model/bg_image_model.dart';

class ImageHelper {
  static Widget buildImage(BgImage? image,
      {BoxFit fit = BoxFit.cover, double? width, double? height}) {
    if (image == null) {
      return Container(
        width: width,
        height: height,
        color: Colors.grey[300],
        child: Icon(Icons.image, color: Colors.grey[600]),
      );
    }

    if (image.imageType == 'asset' && image.assetType != null) {
      // asset images
      return Image.asset(
        'assets/${image.assetType}',
        fit: fit,
        width: width,
        height: height,
        errorBuilder: (context, error, stackTrace) {
          return Image.network(
            image.imageUrl,
            fit: fit,
            width: width,
            height: height,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: width,
                height: height,
                color: Colors.grey[300],
                child: Icon(Icons.broken_image, color: Colors.grey[600]),
              );
            },
          );
        },
      );
    } else {
      // external images
      return Image.network(
        image.imageUrl,
        fit: fit,
        width: width,
        height: height,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: width,
            height: height,
            color: Colors.grey[300],
            child: Icon(Icons.broken_image, color: Colors.grey[600]),
          );
        },
      );
    }
  }

  static DecorationImage? buildDecorationImage(BgImage? image,
      {BoxFit fit = BoxFit.cover}) {
    if (image == null) return null;

    if (image.imageType == 'asset' && image.assetType != null) {
      return DecorationImage(
        image: AssetImage('assets/${image.assetType}'),
        fit: fit,
        onError: (error, stackTrace) {
          print('Asset image error: $error');
        },
      );
    } else {
      return DecorationImage(
        image: NetworkImage(image.imageUrl),
        fit: fit,
        onError: (error, stackTrace) {
          print('Network image error: $error');
        },
      );
    }
  }
}
