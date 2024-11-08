import 'package:get/get.dart';

import '../../provider/api_interface.dart';

class RecipeRepository {
  final ApiProvider api;

  RecipeRepository({ApiProvider? api}) : api = api ?? Get.find<ApiProvider>();
}
