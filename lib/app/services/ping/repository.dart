import 'package:get/get.dart';

import '../../provider/api_interface.dart';
import '../../provider/model/response.dart';
import 'model.dart';

class WelcomeRepository {
  final ApiProvider api;

  WelcomeRepository({ApiProvider? api}) : api = api ?? Get.find<ApiProvider>();

  Future<Pong> getPong() async {
    String url = '/ping';

    CustomHttpResponse response = await api.get(url);

    Pong pong = Pong.fromJson(response.data);

    return pong;
  }
}