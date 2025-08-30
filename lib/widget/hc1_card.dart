import 'package:fampay_assignment/core/convert_hex.dart';
import 'package:fampay_assignment/core/url_handler.dart';
import 'package:flutter/material.dart';

Widget buildCard(dynamic card, double? width) {
  return GestureDetector(
    onTap: () {
      if (card.url != null && card.url.isNotEmpty) {
        // Get context from the current BuildContext
        // Note: This needs to be called from a context where Navigator is available
        UrlHandler.launchURL(card.url);
      }
    },
    child: Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(10),
      width: width,
      decoration: BoxDecoration(
        color: card.bgGradient == null
            ? hexToColor(card.bgColor.toString())
            : null,
        gradient: card.bgGradient != null
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: card.bgGradient!.colors
                    .map((c) => Color(int.parse(c.replaceAll('#', '0xFF'))))
                    .toList(),
                transform:
                    GradientRotation((card.bgGradient!.angle) * 3.14 / 180),
              )
            : null,
        borderRadius: BorderRadius.circular(12),
      ),
      child: IntrinsicWidth(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (card.icon != null)
              CircleAvatar(
                backgroundImage: NetworkImage(card.icon!.imageUrl),
              ),
            const SizedBox(width: 8),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    (card.formattedTitle == null)
                        ? ""
                        : card.formattedTitle.entities.first.text,
                    maxLines: 1,
                    style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    (card.formattedDescription == null)
                        ? ""
                        : card.formattedDescription.entities.first.text,
                    maxLines: 1,
                    style: const TextStyle(
                        overflow: TextOverflow.ellipsis, fontSize: 13),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
