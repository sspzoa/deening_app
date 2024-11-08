import 'package:get/get.dart';

import 'repository.dart';

class PreferenceService extends GetxController {
  final PreferenceRepository repository;

  PreferenceService({PreferenceRepository? repository})
      : repository = repository ?? PreferenceRepository();
}
