import 'package:get/get.dart';

import 'controller.dart';

class RefrigeratorPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RefrigeratorPageController());
  }
}
