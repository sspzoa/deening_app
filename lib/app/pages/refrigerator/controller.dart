import 'package:get/get.dart';

class Ingredient {
  final String name;
  final String amount;
  final String category;

  Ingredient({
    required this.name,
    required this.amount,
    required this.category,
  });
}

class RefrigeratorPageController extends GetxController {
  // 0: 냉장보관, 1: 냉동보관, 2: 상온 보관
  final selectedStorageIndex = 0.obs;

  final refrigeratedItems = <String, List<Ingredient>>{
    '해산물': [
      Ingredient(name: '연어', amount: '300g', category: '해산물'),
      Ingredient(name: '새우', amount: '200g', category: '해산물'),
    ],
    '육류': [
      Ingredient(name: '돼지고기', amount: '500g', category: '육류'),
      Ingredient(name: '닭고기', amount: '400g', category: '육류'),
    ],
    '채소': [
      Ingredient(name: '양파', amount: '3개', category: '채소'),
      Ingredient(name: '당근', amount: '2개', category: '채소'),
    ],
  }.obs;

  final frozenItems = <String, List<Ingredient>>{
    '해산물': [
      Ingredient(name: '고등어', amount: '2마리', category: '해산물'),
      Ingredient(name: '오징어', amount: '3마리', category: '해산물'),
    ],
    '육류': [
      Ingredient(name: '소고기', amount: '1kg', category: '육류'),
      Ingredient(name: '양고기', amount: '500g', category: '육류'),
    ],
  }.obs;

  final roomTempItems = <String, List<Ingredient>>{
    '조미료': [
      Ingredient(name: '소금', amount: '500g', category: '조미료'),
      Ingredient(name: '설탕', amount: '1kg', category: '조미료'),
    ],
    '곡물': [
      Ingredient(name: '쌀', amount: '5kg', category: '곡물'),
      Ingredient(name: '밀가루', amount: '1kg', category: '곡물'),
    ],
  }.obs;

  Map<String, List<Ingredient>> get currentItems {
    switch (selectedStorageIndex.value) {
      case 0:
        return refrigeratedItems;
      case 1:
        return frozenItems;
      case 2:
        return roomTempItems;
      default:
        return {};
    }
  }
}
