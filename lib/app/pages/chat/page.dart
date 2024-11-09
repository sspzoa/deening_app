import 'package:deening_app/app/core/theme/static.dart';
import 'package:deening_app/app/core/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/colors.dart';
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
      appBar: const CustomAppBar(
        title: '요리 비서 디닝',
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(CustomSpacing.spacing550),
              decoration: BoxDecoration(
                color: colorTheme.backgroundStandardSecondary,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            radius: 24,
                            backgroundImage:
                                AssetImage('assets/images/icon.png')
                                    as ImageProvider,
                          ),
                          const SizedBox(height: CustomSpacing.spacing200),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 240),
                            padding: const EdgeInsets.symmetric(
                                horizontal: CustomSpacing.spacing300,
                                vertical: CustomSpacing.spacing200),
                            decoration: BoxDecoration(
                              color: colorTheme.componentsFillStandardPrimary,
                              borderRadius:
                                  BorderRadius.circular(CustomRadius.radius600),
                            ),
                            child: Text(
                              "'해물짬뽕' 레시피에 대해 궁금한 게 있나요?",
                              style: textTheme.footnote.copyWith(
                                color: colorTheme.contentStandardPrimary,
                              ),
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: CustomSpacing.spacing700),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        constraints: const BoxConstraints(maxWidth: 240),
                        padding: const EdgeInsets.symmetric(
                            horizontal: CustomSpacing.spacing300,
                            vertical: CustomSpacing.spacing200),
                        decoration: BoxDecoration(
                          color: colorTheme.coreAccent,
                          borderRadius:
                              BorderRadius.circular(CustomRadius.radius600),
                        ),
                        child: Text(
                          "집에 바지락이 없어서 홍합을 넣고 싶은데 완성된 음식에 어떤 차이가 생길까?",
                          style: textTheme.footnote.copyWith(
                            color: colorTheme.contentInvertedPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            radius: 24,
                            backgroundImage:
                                AssetImage('assets/images/icon.png')
                                    as ImageProvider,
                          ),
                          const SizedBox(height: CustomSpacing.spacing200),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 240),
                            padding: const EdgeInsets.symmetric(
                                horizontal: CustomSpacing.spacing300,
                                vertical: CustomSpacing.spacing200),
                            decoration: BoxDecoration(
                              color: colorTheme.componentsFillStandardPrimary,
                              borderRadius:
                                  BorderRadius.circular(CustomRadius.radius600),
                            ),
                            child: Text(
                              "집에서 바지락 대신 홍합을 사용하면 약간의 차이가 있을 수 있지만 대체로 큰 문제는 없습니다. 홍합은 바지락보다 국물에 더 깊고 진한 해산물 풍미를 더해줍니다. 또한 홍합은 단맛이 조금 더 나기 때문에 결과적으로 국물이 조금 더 부드러워질 수 있습니다. 다만, 홍합을 사용할 경우 바지락보다 크기가 크니 껍데기를 제거하지 않고 넣는다면 식사 중 간편하게 먹을 수 있게 미리 껍데기를 제거하는 것도 좋습니다.",
                              style: textTheme.footnote.copyWith(
                                color: colorTheme.contentStandardPrimary,
                              ),
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
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
                    onTap: () => {},
                    child: Icon(
                      Icons.send_rounded,
                      size: 24,
                      color: colorTheme.coreAccent,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
