import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

import '../../provider/api_interface.dart';
import '../../provider/model/response.dart';
import 'model.dart';

class RefrigeratorRepository {
  final ApiProvider api;

  RefrigeratorRepository({ApiProvider? api})
      : api = api ?? Get.find<ApiProvider>();

  Future<List<String>> detectIngredients({required XFile file}) async {
    String url = '/refrigerator/ingredient-detect';

    MultipartFile image = await MultipartFile.fromFile(file.path,
        contentType: MediaType('image', 'jpeg'));

    CustomHttpResponse response = await api.post(url,
        data: FormData.fromMap({
          'image': image,
        }));

    return List<String>.from(response.data['ingredients']);
  }

  Future<RefrigeratorResponse> getIngredients() async {
    String url = '/refrigerator/ingredients';

    CustomHttpResponse response = await api.get(url);

    RefrigeratorResponse refrigerator =
        RefrigeratorResponse.fromJson(response.data);

    return refrigerator;
  }

  Future<void> addIngredients(
      {required List<NewIngredient> ingredients}) async {
    String url = '/refrigerator/ingredients';

    await api.put(url, data: {ingredients: ingredients});
  }

  Future<void> deleteIngredients({required String ingredientId}) async {
    String url = '/refrigerator/ingredients/$ingredientId';

    await api.delete(url);
  }

  Future<void> updateIngredients(
      {required String ingredientId, required NewIngredient ingredient}) async {
    String url = '/refrigerator/ingredients/$ingredientId';

    await api.patch(url, data: ingredient);
  }

  Future<RefrigeratorResponse> rearrangeRefrigerator() async {
    String url = '/refrigerator/rearrange-refrigerator';

    CustomHttpResponse response = await api.post(url);

    RefrigeratorResponse refrigerator =
        RefrigeratorResponse.fromJson(response.data);

    return refrigerator;
  }
}
