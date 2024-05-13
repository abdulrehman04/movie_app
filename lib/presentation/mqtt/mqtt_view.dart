import 'package:cowlar_task/core/constants/app_colors.dart';
import 'package:cowlar_task/presentation/mqtt/mqtt_view_model.dart';
import 'package:cowlar_task/widgets/button_widgets/custom_long_button.dart';
import 'package:cowlar_task/widgets/text_widgets.dart';
import 'package:cowlar_task/widgets/textfield%20widgets/textfield_with_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part './widgets/bottom_message_bar.dart';
part './widgets/topic_and_messages_section.dart';

class MQTTView extends ConsumerWidget {
  const MQTTView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    MQTTViewModel controller = ref.watch(mqttViewModelProvider);
    return Scaffold(
      bottomNavigationBar:
          controller.connected && controller.topic != 'No Topic'
              ? BottomMessageBar(
                  controller: controller.messageController,
                  onSend: controller.onSendMessage,
                )
              : const SizedBox(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                25.verticalSpace,
                TextWidgets.generalText(
                  controller.connected ? 'Connected' : 'Disconnected',
                  fontSize: 20,
                ),
                15.verticalSpace,
                CustomLongButton(
                  title: controller.connected ? 'Disconnect' : 'Connect',
                  onTap: () {
                    controller.connectDisconnectServer();
                  },
                ),
                55.verticalSpace,
                controller.connected
                    ? const Expanded(child: TopicAndMessagesSection())
                    : TextWidgets.generalText('Please connect to server'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
