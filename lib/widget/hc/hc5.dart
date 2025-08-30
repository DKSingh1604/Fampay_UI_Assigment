import 'package:fampay_assignment/core/url_handler.dart';
import 'package:fampay_assignment/model/hc_group_model.dart';
import 'package:flutter/material.dart';

class HC5Widget extends StatelessWidget {
  final HcGroup group;

  const HC5Widget({Key? key, required this.group}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics:
          group.isScrollable ? ScrollPhysics() : NeverScrollableScrollPhysics(),
      itemCount: group.cards.length,
      itemBuilder: (context, index) {
        final card = group.cards[index];
        return GestureDetector(
          onTap: () {
            if (card.url != null && card.url!.isNotEmpty) {
              UrlHandler.handleDeepLink(card.url, context);
            }
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.all(16),
              child: AspectRatio(
                aspectRatio: card.bgImage?.aspectRatio ?? 1.0,
                child: Image.network(
                  card.bgImage!.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
