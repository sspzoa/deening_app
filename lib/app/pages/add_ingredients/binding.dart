import 'package:deening_app/app/services/refrigerator/service.dart';
import 'package:get/get.dart';

import 'controller.dart';

class AddIngredientsPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RefrigeratorService());
    Get.lazyPut(() => AddIngredientsPageController());
  }
}
