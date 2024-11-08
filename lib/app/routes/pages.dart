import 'package:deening_app/app/pages/refrigerator/page.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../pages/chat/binding.dart';
import '../pages/chat/page.dart';
import '../pages/find_recipe/binding.dart';
import '../pages/find_recipe/page.dart';
import '../pages/home/binding.dart';
import '../pages/home/page.dart';
import '../pages/preference/binding.dart';
import '../pages/preference/page.dart';
import '../pages/recipe/binding.dart';
import '../pages/recipe/page.dart';
import '../pages/refrigerator/binding.dart';
import '../pages/search_result/binding.dart';
import '../pages/search_result/page.dart';
import '../pages/test/binding.dart';
import '../pages/test/page.dart';
import 'routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.TEST,
      page: () => const TestPage(),
      binding: TestPageBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.LICENSE,
      page: () => const LicensePage(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomePage(),
      binding: HomePageBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.REFRIGERATOR,
      page: () => const RefrigeratorPage(),
      binding: RefrigeratorPageBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.PREFERENCE,
      page: () => const PreferencePage(),
      binding: PreferencePageBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.SEARCH_RESULT,
      page: () => const SearchResultPage(),
      binding: SearchResultPageBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.FIND_RECIPE,
      page: () => const FindRecipePage(),
      binding: FindRecipePageBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.RECIPE,
      page: () => const RecipePage(),
      binding: RecipePageBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: Routes.CHAT,
      page: () => const ChatPage(),
      binding: ChatPageBinding(),
      transition: Transition.cupertino,
    ),
  ];
}
