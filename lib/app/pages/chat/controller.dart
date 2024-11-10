import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  @override
  void onInit() {
    super.onInit();
    // 초기 메시지 설정
    messages.addAll([
      ChatMessage(
        text: "'해물짬뽕' 레시피에 대해 궁금한 게 있나요?",
        type: MessageType.receiver,
      ),
      ChatMessage(
        text: "집에 바지락이 없어서 홍합을 넣고 싶은데 완성된 음식에 어떤 차이가 생길까?",
        type: MessageType.sender,
      ),
      ChatMessage(
        text:
            "집에서 바지락 대신 홍합을 사용하면 약간의 차이가 있을 수 있지만 대체로 큰 문제는 없습니다. 홍합은 바지락보다 국물에 더 깊고 진한 해산물 풍미를 더해줍니다. 또한 홍합은 단맛이 조금 더 나기 때문에 결과적으로 국물이 조금 더 부드러워질 수 있습니다. 다만, 홍합을 사용할 경우 바지락보다 크기가 크니 껍데기를 제거하지 않고 넣는다면 식사 중 간편하게 먹을 수 있게 미리 껍데기를 제거하는 것도 좋습니다.",
        type: MessageType.receiver,
      ),
    ]);
  }

  void sendMessage(String text) {
    if (text.isEmpty) return;

    messages.add(ChatMessage(
      text: text,
      type: MessageType.sender,
    ));

    // TODO: Add API call or message processing logic here
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}
