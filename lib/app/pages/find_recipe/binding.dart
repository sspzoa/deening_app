import 'package:get/get.dart';

import 'controller.dart';

class FindRecipePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FindRecipePageController());
  }
}
