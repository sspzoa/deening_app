import 'package:deening_app/app/services/recipe/service.dart';
import 'package:get/get.dart';

import 'controller.dart';

class SearchResultPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RecipeService());
    Get.lazyPut(() => SearchResultPageController());
  }
}
