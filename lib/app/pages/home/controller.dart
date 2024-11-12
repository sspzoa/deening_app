import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/routes.dart';

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
    if (value.trim().isNotEmpty) {
      Get.toNamed(Routes.SEARCH_RESULT, arguments: {'query': value.trim()});
    }
  }

  void onSearchTap() {
    if (searchController.text.trim().isNotEmpty) {
      Get.toNamed(Routes.SEARCH_RESULT,
          arguments: {'query': searchController.text.trim()});
    }
  }
}
