import 'package:get/get.dart';

import 'controller.dart';

class SearchResultPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchResultPageController());
  }
}
