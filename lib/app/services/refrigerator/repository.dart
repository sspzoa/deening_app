import 'package:get/get.dart';

import '../../provider/api_interface.dart';

class RefrigeratorRepository {
  final ApiProvider api;

  RefrigeratorRepository({ApiProvider? api})
      : api = api ?? Get.find<ApiProvider>();
}
