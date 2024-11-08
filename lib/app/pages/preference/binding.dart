import 'package:get/get.dart';

import 'controller.dart';

class PreferencePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PreferencePageController());
  }
}
