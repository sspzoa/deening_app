import 'package:get/get.dart';

import 'repository.dart';

class RefrigeratorService extends GetxController {
  final RefrigeratorRepository repository;

  RefrigeratorService({RefrigeratorRepository? repository})
      : repository = repository ?? RefrigeratorRepository();
}
