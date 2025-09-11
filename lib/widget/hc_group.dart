import 'package:fampay_assignment/model/hc_group_model.dart';
import 'package:fampay_assignment/widget/hc/hc1.dart';
import 'package:fampay_assignment/widget/hc/hc3.dart';
import 'package:fampay_assignment/widget/hc/hc5.dart';
import 'package:fampay_assignment/widget/hc/hc6.dart';
import 'package:fampay_assignment/widget/hc/hc9.dart';
import 'package:flutter/material.dart';

class HcGroupWidget extends StatelessWidget {
  final HcGroup group;

  const HcGroupWidget({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    switch (group.designType) {
      case 'HC3':
        return HC3Widget(group: group);
      case 'HC6':
        return HC6Widget(group: group);
      case 'HC5':
        return HC5Widget(group: group);
      case 'HC9':
        return HC9Widget(group: group);
      case 'HC1':
        return HC1Widget(group: group);
      default:
        return const SizedBox.shrink();
    }
  }
}
