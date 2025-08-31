import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class UrlHandler {
  static Future<void> launchURL(String? url) async {
    if (url == null || url.isEmpty) return;

    try {
      final Uri uri = Uri.parse(url);

      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        await launchUrl(
          uri,
          mode: LaunchMode.inAppWebView,
        );
      }
    } catch (e) {
      debugPrint('Error launching URL: $url, Error: $e');
    }
  }

  static Future<void> handleDeepLink(String? url, BuildContext context) async {
    if (url == null || url.isEmpty) return;

    //to habdle different deeplinks
    if (url.startsWith('http') || url.startsWith('https')) {
      await launchURL(url);
    } else if (url.startsWith('tel:')) {
      await launchURL(url);
    } else if (url.startsWith('mailto:')) {
      await launchURL(url);
    } else if (url.startsWith('sms:')) {
      await launchURL(url);
    } else {
      await launchURL(url);
    }
  }
}
