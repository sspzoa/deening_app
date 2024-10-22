import 'package:deening_app/app/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class PreferencePage extends GetView<PreferencePageController> {
  const PreferencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: '선호 키워드'),
      body: SafeArea(
        child: Center(
          child: Text('Preference'),
        ),
      ),
    );
  }
}
