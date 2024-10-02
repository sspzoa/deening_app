import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/colors.dart';
import '../../core/theme/typography.dart';

import 'controller.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    CustomColors colorTheme = Theme.of(context).extension<CustomColors>()!;
    CustomTypography textTheme = Theme.of(context).extension<CustomTypography>()!;
    return Scaffold(
      appBar: AppBar(
        title: const Text("디닝"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Obx(
            () {
              final pong = controller.pingService.pong;
              if (pong == null) {
                return Center(
                    child: CircularProgressIndicator(
                  color: colorTheme.coreAccent,
                ));
              }
              return Center(
                child: Text(
                  pong.message,
                  style: textTheme.display,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
