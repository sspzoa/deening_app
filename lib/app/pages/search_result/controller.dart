import 'package:get/get.dart';

import '../../routes/routes.dart';
import '../../services/recipe/model.dart';
import '../../services/recipe/service.dart';

class SearchResultPageController extends GetxController {
  final RecipeService _recipeService = Get.find<RecipeService>();

  final RxList<RecipeSearchResult> searchResults = <RecipeSearchResult>[].obs;
  final RxBool isLoading = false.obs;
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Get arguments from navigation
    if (Get.arguments != null && Get.arguments['query'] != null) {
      searchQuery.value = Get.arguments['query'];
      searchRecipes(searchQuery.value);
    }
  }

  Future<void> searchRecipes(String query) async {
    try {
      isLoading.value = true;
      final response = await _recipeService.searchRecipes(query: query);
      searchResults.value = response.searchResults;
    } finally {
      isLoading.value = false;
    }
  }

  void onRecipeTap(String recipeName) {
    Get.toNamed(
      Routes.RECIPE,
      arguments: {
        'foodName': recipeName,
        'useRefrigerator': false,
      },
    );
  }
}
