import 'package:get/get.dart';

import 'controller.dart';

class AddIngredientsPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddIngredientsPageController());
  }
}
