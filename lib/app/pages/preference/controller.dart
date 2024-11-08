import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Keyword {
  final String name;

  Keyword({
    required this.name,
  });
}

class PreferencePageController extends GetxController {
  final selectedPreferenceIndex = 0.obs;
  final keywordController = TextEditingController();

  final likedKeywords = <Keyword>[
    Keyword(name: '연어'),
    Keyword(name: '돼지고기'),
    Keyword(name: '양파'),
    Keyword(name: '고등어'),
    Keyword(name: '소고기'),
    Keyword(name: '소금'),
    Keyword(name: '쌀'),
  ].obs;

  final dislikedKeywords = <Keyword>[
    Keyword(name: '새우'),
    Keyword(name: '닭고기'),
    Keyword(name: '당근'),
    Keyword(name: '오징어'),
    Keyword(name: '양고기'),
    Keyword(name: '설탕'),
    Keyword(name: '밀가루'),
  ].obs;

  List<Keyword> get currentKeywords {
    switch (selectedPreferenceIndex.value) {
      case 0:
        return likedKeywords;
      case 1:
        return dislikedKeywords;
      default:
        return [];
    }
  }

  void addKeyword(String keyword) {
    if (keyword.isEmpty) return;

    final newKeyword = Keyword(name: keyword);
    if (selectedPreferenceIndex.value == 0) {
      likedKeywords.add(newKeyword);
    } else {
      dislikedKeywords.add(newKeyword);
    }
    keywordController.clear();
  }

  @override
  void onClose() {
    keywordController.dispose();
    super.onClose();
  }
}
