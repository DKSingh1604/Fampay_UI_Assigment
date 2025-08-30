import 'package:fampay_assignment/controller/card_controller.dart';
import 'package:fampay_assignment/core/convert_hex.dart';
import 'package:fampay_assignment/static/app_assets.dart';
import 'package:fampay_assignment/widget/hc_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final ApiController controller = Get.put(ApiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexToColor('#F7F6F3'),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: SvgPicture.asset(
            AppAssets.fampaylogo,
            width: 30,
            height: 25,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.refreshData(),
        child: Obx(() {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.error.isNotEmpty) {
            return Center(child: Text(controller.error));
          }

          return ListView.builder(
            itemCount: controller.apiData.first.hcGroups.length,
            itemBuilder: (context, index) {
              final group = controller.apiData.first.hcGroups[index];
              return HcGroupWidget(group: group);
            },
          );
        }),
      ),
    );
  }
}







