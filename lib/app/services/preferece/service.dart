import 'package:get/get.dart';

import 'model.dart';
import 'repository.dart';

class PreferenceService extends GetxController {
  final PreferenceRepository repository;

  PreferenceService({PreferenceRepository? repository})
      : repository = repository ?? PreferenceRepository();

  Future<PreferenceResponse> getKeywords() async {
    return await repository.getKeywords();
  }

  Future<void> addKeywords({required NewKeyword keyword}) async {
    await repository.addKeyword(keyword: keyword);
  }

  Future<void> deleteKeywords({required String keywordId}) async {
    await repository.deleteKeyword(keywordId: keywordId);
  }

  Future<void> updateKeywords(
      {required String keywordId, required NewKeyword keyword}) async {
    await repository.updateKeyword(keywordId: keywordId, keyword: keyword);
  }
}
