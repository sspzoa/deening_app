import 'package:get/get.dart';

import 'repository.dart';

class RecipeService extends GetxController {
  final RecipeRepository repository;

  RecipeService({RecipeRepository? repository})
      : repository = repository ?? RecipeRepository();
}
