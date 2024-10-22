import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/colors.dart';
import '../../core/theme/static.dart';
import '../../widgets/appBar.dart';
import '../../widgets/gestureDetector.dart';
import 'controller.dart';

class RefrigeratorPage extends GetView<RefrigeratorPageController> {
  const RefrigeratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<CustomColors>()!;

    return Scaffold(
      appBar: CustomAppBar(
        title: '내 냉장고',
        actions: [
          Row(
            children: [
              CustomGestureDetectorWithOpacityInteraction(
                onTap: () => {},
                child: Icon(
                  Icons.add_rounded,
                  size: 24,
                  color: colorTheme.contentStandardSecondary,
                ),
              ),
              const SizedBox(width: CustomSpacing.spacing300),
              CustomGestureDetectorWithOpacityInteraction(
                onTap: () => {},
                child: Icon(
                  Icons.refresh_rounded,
                  size: 24,
                  color: colorTheme.contentStandardSecondary,
                ),
              ),
              const SizedBox(width: CustomSpacing.spacing550),
            ],
          )
        ],
      ),
      body: const SafeArea(
        child: Center(
          child: Text('Refrigerator'),
        ),
      ),
    );
  }
}
