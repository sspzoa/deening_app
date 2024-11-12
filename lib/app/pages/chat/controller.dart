import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/recipe/service.dart';

enum MessageType { sender, receiver }

class ChatMessage {
  final String text;
  final MessageType type;

  ChatMessage({
    required this.text,
    required this.type,
  });
}

class ChatPageController extends GetxController {
  final messages = <ChatMessage>[].obs;
  final TextEditingController textController = TextEditingController();

  // RecipeService 인스턴스
  final RecipeService _recipeService = Get.find<RecipeService>();

  // 레시피 정보 저장
  late final String foodName;
  late final String recipeId;

  // 로딩 상태 관리
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    // Get.arguments에서 데이터 추출
    final args = Get.arguments as Map<String, dynamic>;
    foodName = args['foodName'] as String;
    recipeId = args['recipeId'] as String;

    // 초기 메시지 설정
    messages.add(
      ChatMessage(
        text: "'$foodName' 레시피에 대해 궁금한 게 있나요?",
        type: MessageType.receiver,
      ),
    );
  }

  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;

    // 사용자 메시지 추가
    messages.add(ChatMessage(
      text: text,
      type: MessageType.sender,
    ));

    try {
      isLoading.value = true;

      // API 호출하여 응답 받기
      final response = await _recipeService.chatWithRecipe(
        recipeId: recipeId,
        question: text,
      );

      // 응답 메시지 추가
      messages.add(ChatMessage(
        text: response,
        type: MessageType.receiver,
      ));
    } catch (e) {
      // 에러 메시지 추가
      messages.add(ChatMessage(
        text: "죄송합니다. 답변을 생성하는 중에 문제가 발생했습니다. 다시 시도해 주세요.",
        type: MessageType.receiver,
      ));
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}
