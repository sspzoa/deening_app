import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/colors.dart';
import '../../core/theme/typography.dart';

import 'controller.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    DanAColors colorTheme = Theme.of(context).extension<DanAColors>()!;
    DanATypography textTheme = Theme.of(context).extension<DanATypography>()!;
    return Scaffold(
      appBar: AppBar(
        title: const Text("디닝"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Obx(
            () {
              final welcome = controller.pingService.welcome;
              if (welcome == null) {
                return Center(
                    child: CircularProgressIndicator(
                  color: colorTheme.coreAccent,
                ));
              }
              return Center(
                child: Text(
                  welcome.message,
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
