import 'package:flutter/material.dart';

Color hexToColor(String code) {
  try {
    // Remove any whitespace
    code = code.trim();

    // Handle empty or null strings
    if (code.isEmpty) {
      return Colors.transparent;
    }

    // Remove the # if present
    if (code.startsWith('#')) {
      code = code.substring(1);
    }

    // Handle different hex code lengths
    if (code.length == 3) {
      // Convert RGB to RRGGBB (e.g., "F0A" -> "FF00AA")
      code = code.split('').map((char) => char + char).join();
    } else if (code.length == 6) {
      // Standard RRGGBB format - keep as is
    } else if (code.length == 8) {
      // AARRGGBB format - rearrange to RRGGBBAA for Flutter
      String alpha = code.substring(0, 2);
      String rgb = code.substring(2);
      code = rgb + alpha;
    } else {
      // Invalid format, return a default color
      print('Invalid hex color format: $code');
      return Colors.grey;
    }

    // Ensure we have exactly 6 characters for RGB
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
