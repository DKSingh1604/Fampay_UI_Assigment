import 'dart:developer';

import 'package:fampay_assignment/core/convert_hex.dart';
import 'package:fampay_assignment/core/url_handler.dart';
import 'package:fampay_assignment/model/hc_group_model.dart';
import 'package:flutter/material.dart';

class HC6Widget extends StatelessWidget {
  final HcGroup group;

  const HC6Widget({Key? key, required this.group}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      height: group.height! + 25.toDouble(),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: group.isScrollable
            ? ScrollPhysics()
            : NeverScrollableScrollPhysics(),
        itemCount: group.cards.length,
        itemBuilder: (context, index) {
          final card = group.cards[index];
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
            width: MediaQuery.of(context).size.width - 32,
            decoration: BoxDecoration(
              color: card.bgGradient == null
                  ? hexToColor(card.bgColor.toString())
                  : null,
              gradient: card.bgGradient != null
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: card.bgGradient!.colors
                          .map((c) =>
                              Color(int.parse(c.replaceAll('#', '0xFF'))))
                          .toList(),
                      transform: GradientRotation(
                          (card.bgGradient!.angle) * 3.14 / 180),
                    )
                  : null,
              borderRadius: BorderRadius.circular(8),
            ),
            child: GestureDetector(
              onTap: () {
                if (card.url != null && card.url!.isNotEmpty) {
                  UrlHandler.handleDeepLink(card.url, context);
                }
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (card.icon != null)
                    Image.network(
                      card.icon!.imageUrl,
                      height: card.iconSize! + 9.toDouble(),
                    ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      card.formattedTitle!.entities.first.text.toString(),
                      style: TextStyle(
                        fontSize: card.formattedTitle!.entities.first.fontSize
                            ?.toDouble(),
                        color: hexToColor(card
                            .formattedTitle!.entities.first.color
                            .toString()),
                        fontWeight:
                            card.formattedTitle!.entities.first.fontFamily ==
                                    'met_semi_bold'
                                ? FontWeight.w500
                                : FontWeight.w700,
                      ),
                    ),
                  ),
                  Icon(Icons.chevron_right),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
