import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class UrlHandler {
  static Future<void> launchURL(String? url) async {
    if (url == null || url.isEmpty) return;

    try {
      final Uri uri = Uri.parse(url);

      // Check if the URL can be launched
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        // If external app can't handle it, try in-app browser
        await launchUrl(
          uri,
          mode: LaunchMode.inAppWebView,
        );
      }
    } catch (e) {
      debugPrint('Error launching URL: $url, Error: $e');
      // Could show a snackbar or toast here for user feedback
    }
  }

  static Future<void> handleDeepLink(String? url, BuildContext context) async {
    if (url == null || url.isEmpty) return;

    // Handle different types of deep links
    if (url.startsWith('http') || url.startsWith('https')) {
      await launchURL(url);
    } else if (url.startsWith('tel:')) {
      await launchURL(url);
    } else if (url.startsWith('mailto:')) {
      await launchURL(url);
    } else if (url.startsWith('sms:')) {
      await launchURL(url);
    } else {
      // Handle custom app schemes or other deep links
      await launchURL(url);
    }
  }
}
