import 'package:fampay_assignment/core/url_handler.dart';
import 'package:fampay_assignment/model/hc_group_model.dart';
import 'package:flutter/material.dart';

class HC9Widget extends StatelessWidget {
  final HcGroup group;

  const HC9Widget({Key? key, required this.group}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16),
      height: group.height?.toDouble() ?? 195,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const ScrollPhysics(),
        itemCount: group.cards.length,
        itemBuilder: (context, index) {
          final card = group.cards[index];
          return GestureDetector(
            onTap: () {
              if (card.url != null && card.url!.isNotEmpty) {
                UrlHandler.handleDeepLink(card.url, context);
              }
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: card.bgGradient?.colors
                          .map((c) =>
                              Color(int.parse(c.replaceAll('#', '0xFF'))))
                          .toList() ??
                      [Colors.transparent],
                  transform: GradientRotation(
                      (card.bgGradient?.angle ?? 0) * 3.14 / 180),
                ),
              ),
              child: Image.network(card.bgImage!.imageUrl.toString()),
            ),
          );
        },
      ),
    );
  }
}
