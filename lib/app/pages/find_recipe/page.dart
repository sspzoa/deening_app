import 'package:deening_app/app/core/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/colors.dart';
import 'controller.dart';

class FindRecipePage extends GetView<FindRecipePageController> {
  const FindRecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<CustomColors>()!;
    final textTheme = Theme.of(context).extension<CustomTypography>()!;
    return const Scaffold(
      body: SafeArea(
          child: Center(
        child: Text('This is Find Recipe Page.'),
      )),
    );
  }
}
