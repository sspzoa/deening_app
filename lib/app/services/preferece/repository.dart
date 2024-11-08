import 'package:get/get.dart';

import '../../provider/api_interface.dart';

class PreferenceRepository {
  final ApiProvider api;

  PreferenceRepository({ApiProvider? api})
      : api = api ?? Get.find<ApiProvider>();
}
