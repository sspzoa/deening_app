import 'package:get/get.dart';

import '../../services/recipe/service.dart';
import 'controller.dart';

class ChatPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RecipeService());
    Get.lazyPut(() => ChatPageController());
  }
}
