import 'package:deening_app/app/services/preferece/service.dart';
import 'package:get/get.dart';

import 'controller.dart';

class PreferencePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PreferenceService());
    Get.lazyPut(() => PreferencePageController());
  }
}
