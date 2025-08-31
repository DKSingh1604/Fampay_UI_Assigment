import 'package:flutter/material.dart';

Color hexToColor(String code) {
  try {
    code = code.trim();

    if (code.isEmpty) {
      return Colors.transparent;
    }

    if (code.startsWith('#')) {
      code = code.substring(1);
    }

    if (code.length == 3) {
      code = code.split('').map((char) => char + char).join();
    } else if (code.length == 6) {
    } else if (code.length == 8) {
      String alpha = code.substring(0, 2);
      String rgb = code.substring(2);
      code = rgb + alpha;
    } else {
      print('Invalid hex color format: $code');
      return Colors.grey;
    }

    if (code.length == 6) {
      return Color(int.parse(code, radix: 16) + 0xFF000000);
    } else if (code.length == 8) {
      return Color(int.parse(code, radix: 16));
    } else {
      return Colors.grey;
    }
  } catch (e) {
    print('Error parsing hex color "$code": $e');
    return Colors.grey;
  }
}
