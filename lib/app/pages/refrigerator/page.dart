import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class RefrigeratorPage extends GetView<RefrigeratorPageController> {
  const RefrigeratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Text('Refrigerator'),
      ),
    );
  }
}