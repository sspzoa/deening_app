import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/colors.dart';
import '../../core/theme/static.dart';
import '../../core/theme/typography.dart';
import '../../widgets/appBar.dart';
import '../../widgets/gestureDetector.dart';
import 'controller.dart';

class ChatPage extends GetView<ChatPageController> {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<CustomColors>()!;
    final textTheme = Theme.of(context).extension<CustomTypography>()!;

    return Scaffold(
      appBar: const CustomAppBar(title: '요리 비서 디닝'),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(CustomSpacing.spacing550),
                decoration: BoxDecoration(
                  color: colorTheme.backgroundStandardSecondary,
                ),
                child: Obx(() => ListView.separated(
                      itemCount: controller.messages.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: CustomSpacing.spacing700),
                      itemBuilder: (context, index) {
                        final message = controller.messages[index];
                        return MessageBubble(
                          message: message.text,
                          type: message.type,
                          showAvatar: index == 0 ||
                              controller.messages[index - 1].type !=
                                  message.type,
                        );
                      },
                    )),
              ),
            ),
            ChatInput(
              controller: controller.textController,
              onSend: controller.sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String message;
  final MessageType type;
  final bool showAvatar;

  const MessageBubble({
    super.key,
    required this.message,
    required this.type,
    this.showAvatar = true,
  });

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<CustomColors>()!;
    final textTheme = Theme.of(context).extension<CustomTypography>()!;

    return Row(
      mainAxisAlignment: type == MessageType.sender
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (type == MessageType.receiver && showAvatar) ...[
          const CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage('assets/images/icon.png'),
          ),
          const SizedBox(width: CustomSpacing.spacing200),
        ],
        Container(
          constraints: const BoxConstraints(maxWidth: 240),
          padding: const EdgeInsets.symmetric(
            horizontal: CustomSpacing.spacing300,
            vertical: CustomSpacing.spacing200,
          ),
          decoration: BoxDecoration(
            color: type == MessageType.sender
                ? colorTheme.coreAccent
                : colorTheme.componentsFillStandardPrimary,
            borderRadius: BorderRadius.circular(CustomRadius.radius600),
          ),
          child: Text(
            message,
            style: textTheme.footnote.copyWith(
              color: type == MessageType.sender
                  ? colorTheme.contentInvertedPrimary
                  : colorTheme.contentStandardPrimary,
              fontWeight: type == MessageType.sender ? FontWeight.bold : null,
            ),
            softWrap: true,
          ),
        ),
      ],
    );
  }
}

class ChatInput extends StatelessWidget {
  final void Function(String) onSend;
  final TextEditingController controller;

  const ChatInput({
    super.key,
    required this.onSend,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<CustomColors>()!;
    final textTheme = Theme.of(context).extension<CustomTypography>()!;

    return Container(
      padding: const EdgeInsets.all(CustomSpacing.spacing550),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: CustomSpacing.spacing300,
          vertical: CustomSpacing.spacing200,
        ),
        decoration: BoxDecoration(
          color: colorTheme.backgroundStandardPrimary,
          borderRadius: BorderRadius.circular(CustomRadius.radiusFull),
          border: Border.all(
            color: colorTheme.lineOutline,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                style: textTheme.label.copyWith(
                  color: colorTheme.contentStandardSecondary,
                ),
                decoration: InputDecoration(
                  hintText: '디닝에게 메시지 입력',
                  hintStyle: textTheme.label.copyWith(
                    color: colorTheme.contentStandardTertiary,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                ),
                textAlignVertical: TextAlignVertical.center,
              ),
            ),
            CustomGestureDetectorWithOpacityInteraction(
              onTap: () {
                if (controller.text.isNotEmpty) {
                  onSend(controller.text);
                  controller.clear();
                }
              },
              child: Icon(
                Icons.send_rounded,
                size: 24,
                color: colorTheme.coreAccent,
              ),
            )
          ],
        ),
      ),
    );
  }
}
