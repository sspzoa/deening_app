import 'package:get/get.dart';

import '../../services/ping/service.dart';

class HomePageController extends GetxController {
  final PingService pingService = Get.find<PingService>();

  @override
  void onInit() {
    super.onInit();
    fetchWelcome();
  }

  Future<void> fetchWelcome() async {
    await pingService.ping();
  }
}
