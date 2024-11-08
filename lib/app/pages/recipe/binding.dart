import 'package:get/get.dart';

import 'controller.dart';

class RecipePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RecipePageController());
  }
}
