import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../pages/home/binding.dart';
import '../pages/home/page.dart';
import '../pages/test/binding.dart';
import '../pages/test/page.dart';
import 'routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.TEST,
      page: () => const TestPage(),
      binding: TestPageBinding(),
    ),
    GetPage(
      name: Routes.LICENSE,
      page: () => const LicensePage(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomePage(),
      binding: HomePageBinding(),
    ),
  ];
}
