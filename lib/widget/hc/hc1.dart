// ignore_for_file: use_super_parameters

import 'package:fampay_assignment/model/hc_group_model.dart';
import 'package:fampay_assignment/widget/hc1_card.dart';
import 'package:flutter/material.dart';

class HC1Widget extends StatelessWidget {
  final HcGroup group;

  const HC1Widget({Key? key, required this.group}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (group.cards.length == 1) {
      return Container(
        margin: const EdgeInsets.all(16),
        height: group.height?.toDouble() ?? 64,
        child:
            buildCard(group.cards[0], MediaQuery.of(context).size.width - 32),
      );
    }

    return Container(
      margin: const EdgeInsets.all(20),
      height: group.height?.toDouble() ?? 64,
      child: group.isScrollable
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: group.cards.length,
              itemBuilder: (context, index) {
                return buildCard(group.cards[index], null);
              },
            )
          : LayoutBuilder(
              builder: (context, constraints) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: group.cards.map((card) {
                    double cardWidth =
                        (constraints.maxWidth - (9.0 * (group.cards.length))) /
                            group.cards.length;
                    return buildCard(card, cardWidth);
                  }).toList(),
                );
              },
            ),
    );
  }
}
