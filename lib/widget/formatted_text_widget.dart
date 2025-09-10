import 'package:fampay_assignment/core/convert_hex.dart';
import 'package:fampay_assignment/core/url_handler.dart';
import 'package:fampay_assignment/model/formatted_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class FormattedTextWidget extends StatelessWidget {
  final Formatted? formatted;

  const FormattedTextWidget({Key? key, this.formatted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (formatted == null) return const SizedBox.shrink();

    final text = formatted!.text;
    final entities = formatted!.entities;

    final parts = text.split(RegExp(r'\{\}'));
    List<InlineSpan> spans = [];

    double firstFontSize =
        entities.isNotEmpty ? entities[0].fontSize?.toDouble() ?? 19 : 19;
    Color firstColor = Colors.white;

    for (int i = 0; i < parts.length; i++) {
      if (parts[i].isNotEmpty) {
        spans.add(TextSpan(
          text: parts[i],
          style: TextStyle(
            fontSize: firstFontSize,
            color: firstColor,
          ),
        ));
      }

      if (i < entities.length) {
        final entity = entities[i];

        spans.add(
          TextSpan(
            text: entity.text,
            recognizer: entity.url != null && entity.url!.isNotEmpty
                ? (TapGestureRecognizer()
                  ..onTap = () {
                    UrlHandler.handleDeepLink(entity.url, context);
                  })
                : null,
            style: TextStyle(
              overflow: TextOverflow.ellipsis,
              color: entity.color != null
                  ? hexToColor(entity.color.toString())
                  : firstColor,
              fontSize: entity.fontSize?.toDouble() ?? firstFontSize,
              fontStyle: entity.fontStyle == 'italic'
                  ? FontStyle.italic
                  : FontStyle.normal,
              fontFamily: entity.fontFamily,
              fontWeight: entity.fontFamily == 'met_semi_bold'
                  ? FontWeight.w500
                  : FontWeight.w400,
            ),
          ),
        );
      }

      if (i < parts.length - 1) {
        spans.add(const TextSpan(
          text: ' ',
          style: TextStyle(
            fontSize: 10,
          ),
        ));
      }
    }

    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: spans,
      ),
      textAlign:
          formatted!.align == 'center' ? TextAlign.center : TextAlign.left,
    );
  }
}
