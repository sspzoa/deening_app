import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/preferece/model.dart';
import '../../services/preferece/service.dart';

class PreferencePageController extends GetxController {
  final PreferenceService _service;
  final selectedPreferenceIndex = 0.obs;
  final keywordController = TextEditingController();
  final keywords = <Keyword>[].obs;

  PreferencePageController({PreferenceService? service})
      : _service = service ?? Get.find<PreferenceService>();

  @override
  void onInit() {
    super.onInit();
    fetchKeywords();
  }

  Future<void> fetchKeywords() async {
    try {
      final response = await _service.getKeywords();
      keywords.value = response.preference.keywords;
    } catch (e) {
      print('Error fetching keywords: $e');
    }
  }

  List<Keyword> get likedKeywords =>
      keywords.where((k) => k.type == KeywordType.like).toList();

  List<Keyword> get dislikedKeywords =>
      keywords.where((k) => k.type == KeywordType.dislike).toList();

  List<Keyword> get currentKeywords {
    return selectedPreferenceIndex.value == 0
        ? likedKeywords
        : dislikedKeywords;
  }

  Future<void> addKeyword(String name) async {
    if (name.isEmpty) return;

    try {
      final newKeyword = NewKeyword(
        name: name,
        type: selectedPreferenceIndex.value == 0
            ? KeywordType.like
            : KeywordType.dislike,
      );

      await _service.addKeywords(keyword: newKeyword);
      await fetchKeywords();
      keywordController.clear();
    } catch (e) {
      print('Error adding keyword: $e');
    }
  }

  Future<void> updateKeyword(String keywordId, String newName) async {
    try {
      final keyword = keywords.firstWhere((k) => k.id == keywordId);
      final updatedKeyword = NewKeyword(
        name: newName,
        type: keyword.type,
      );

      await _service.updateKeywords(
          keywordId: keywordId, keyword: updatedKeyword);
      await fetchKeywords();
    } catch (e) {
      print('Error updating keyword: $e');
    }
  }

  Future<void> deleteKeyword(String keywordId) async {
    try {
      await _service.deleteKeywords(keywordId: keywordId);
      await fetchKeywords();
    } catch (e) {
      print('Error deleting keyword: $e');
    }
  }

  @override
  void onClose() {
    keywordController.dispose();
    super.onClose();
  }
}
