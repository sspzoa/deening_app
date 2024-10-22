import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class PreferencePage extends GetView<PreferencePageController> {
  const PreferencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Text('Keywords'),
      ),
    );
  }
}
