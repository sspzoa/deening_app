import 'package:deening_app/app/services/ping/service.dart';
import 'package:get/get.dart';

import 'controller.dart';

class HomePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomePageController());
    Get.lazyPut(() => PingService());
  }
}
