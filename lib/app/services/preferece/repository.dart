import 'package:get/get.dart';

import '../../provider/api_interface.dart';
import '../../provider/model/response.dart';
import 'model.dart';

class PreferenceRepository {
  final ApiProvider api;

  PreferenceRepository({ApiProvider? api})
      : api = api ?? Get.find<ApiProvider>();

  Future<PreferenceResponse> getKeywords() async {
    String url = '/preference/keywords';

    CustomHttpResponse response = await api.get(url);

    PreferenceResponse preference = PreferenceResponse.fromJson(response.data);

    return preference;
  }

  Future<void> addKeyword({required NewKeyword keyword}) async {
    String url = '/preference/keywords';

    await api.put(url, data: keyword);
  }

  Future<void> deleteKeyword({required String keywordId}) async {
    String url = '/preference/keywords/$keywordId';

    await api.delete(url);
  }

  Future<void> updateKeyword(
      {required String keywordId, required NewKeyword keyword}) async {
    String url = '/preference/keywords/$keywordId';

    await api.patch(url, data: keyword);
  }
}
