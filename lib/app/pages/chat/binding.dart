import 'package:get/get.dart';

import 'controller.dart';

class ChatPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatPageController());
  }
}
