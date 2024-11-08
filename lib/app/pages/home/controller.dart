import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  final searchController = TextEditingController();

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void onSearchChanged(String value) {
    debugPrint('Search query changed: $value');
  }

  void onSearchSubmitted(String value) {
    debugPrint('Search submitted: $value');
  }
}
