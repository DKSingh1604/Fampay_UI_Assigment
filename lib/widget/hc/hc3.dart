import 'package:fampay_assignment/core/url_handler.dart';
import 'package:fampay_assignment/model/hc_group_model.dart';
import 'package:fampay_assignment/static/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fampay_assignment/controller/hc3_controller.dart';
import 'package:fampay_assignment/core/convert_hex.dart';
import 'package:fampay_assignment/widget/formatted_text_widget.dart';

class HC3Widget extends StatefulWidget {
  final HcGroup group;

  const HC3Widget({Key? key, required this.group}) : super(key: key);

  @override
  _HC3WidgetState createState() => _HC3WidgetState();
}

class _HC3WidgetState extends State<HC3Widget> {
  bool isExpanded = false;
  late final HC3 controller;
  String get cardId => '${widget.group.cards.first.id}';

  @override
  void initState() {
    super.initState();
    controller = Get.put(HC3());
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final normalWidth = screenWidth - 32;
    final slideOffset = screenWidth * 0.4; // How much to slide right

    return Obx(() {
      if (!controller.isCardVisible(cardId)) {
        return const SizedBox.shrink();
      }

      return Container(
        margin: const EdgeInsets.all(16),
        height: widget.group.height! - 240.toDouble(),
        child: Stack(
          children: [
            // Background container with action buttons
            buildUnderlyingCOntainer(context),

            // Main card that slides over the background
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              left: isExpanded ? slideOffset : 0,
              top: 0,
              bottom: 0,
              width: normalWidth,
              child: GestureDetector(
                onLongPress: () {
                  setState(() {
                    isExpanded = true;
                  });
                },
                onTap: () {
                  if (isExpanded) {
                    setState(() {
                      isExpanded = false;
                    });
                  } else {
                    // Handle card tap - launch URL if available
                    final cardUrl = widget.group.cards.first.url;
                    if (cardUrl != null && cardUrl.isNotEmpty) {
                      UrlHandler.handleDeepLink(cardUrl, context);
                    }
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.group.cards.first.bgColor != null
                        ? hexToColor(widget.group.cards.first.bgColor!)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    gradient: widget.group.cards.first.bgGradient != null
                        ? LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: widget.group.cards.first.bgGradient!.colors
                                .map((c) =>
                                    Color(int.parse(c.replaceAll('#', '0xFF'))))
                                .toList(),
                            transform: GradientRotation(
                                (widget.group.cards.first.bgGradient!.angle) *
                                    3.14 /
                                    180),
                          )
                        : null,
                    image: widget.group.cards.first.bgImage != null
                        ? DecorationImage(
                            image: NetworkImage(
                                widget.group.cards.first.bgImage!.imageUrl),
                            fit: BoxFit.fill,
                          )
                        : null,
                  ),
                  child: buildUpperContainer(normalWidth),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget buildUnderlyingCOntainer(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              controller.remindLater(cardId);
              setState(() {
                isExpanded = false;
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.25,
              height: MediaQuery.of(context).size.height * 0.11,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: hexToColor('#F7F6F3'),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppAssets.bell),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                  const Text(
                    'Remind later',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.09,
          ),
          GestureDetector(
            onTap: () {
              controller.dismissNow(cardId);
              setState(() {
                isExpanded = false;
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.25,
              height: MediaQuery.of(context).size.height * 0.11,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: hexToColor('#F7F6F3'),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppAssets.cancel),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                  const Text(
                    'Dismiss now',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildUpperContainer(double normalWidth) {
    return Container(
      width: normalWidth,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 16),
            child: FormattedTextWidget(
              formatted: widget.group.cards.first.formattedTitle,
            ),
          ),
          if (widget.group.cards.first.cta != null &&
              widget.group.cards.first.cta!.isNotEmpty)
            ElevatedButton(
              onPressed: () {
                final cta = widget.group.cards.first.cta!.first;
                if (cta.url != null && cta.url!.isNotEmpty) {
                  UrlHandler.handleDeepLink(cta.url, context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: hexToColor(
                  widget.group.cards.first.cta!.first.bgColor.toString(),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    widget.group.cards.first.cta!.first.isCircular ? 24 : 8,
                  ),
                ),
              ),
              child: Text(
                widget.group.cards.first.cta!.first.text,
                style: TextStyle(
                    color: hexToColor(
                        widget.group.cards.first.cta!.first.textColor ??
                            '#FFFFFF')),
              ),
            ),
        ],
      ),
    );
  }
}
