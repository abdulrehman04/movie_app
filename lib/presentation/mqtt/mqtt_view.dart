import 'package:cowlar_task/core/constants/app_colors.dart';
import 'package:cowlar_task/presentation/mqtt/mqtt_view_model.dart';
import 'package:cowlar_task/widgets/button_widgets/custom_long_button.dart';
import 'package:cowlar_task/widgets/text_widgets.dart';
import 'package:cowlar_task/widgets/textfield%20widgets/textfield_with_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part './widgets/bottom_message_bar.dart';

class MQTTView extends ConsumerWidget {
  const MQTTView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    MQTTViewModel controller = ref.watch(mqttViewModelProvider);
    return Scaffold(
      bottomNavigationBar: BottomMessageBar(
        controller: controller.messageController,
        onSend: controller.onSendMessage,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                25.verticalSpace,
                TextWidgets.generalText(
                  controller.connectionStatus,
                  fontSize: 20,
                ),
                15.verticalSpace,
                CustomLongButton(
                  title: controller.connectionStatus == 'Connected'
                      ? 'Disconnect'
                      : 'Connect',
                  onTap: () {
                    controller.connectDisconnectServer();
                  },
                ),
                55.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      child: TextfieldWithTitle(
                        title: 'Topic',
                        controller: controller.topicController,
                      ),
                    ),
                    15.horizontalSpace,
                    GestureDetector(
                      onTap: () {
                        controller.subscribeToTopic();
                      },
                      child: Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.blue[300],
                        ),
                        child: Icon(
                          Icons.send,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
                15.verticalSpace,
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextWidgets.headingWidget(controller.topic),
                ),
                10.verticalSpace,
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[200],
                    ),
                    padding: const EdgeInsets.all(15),
                    child: controller.messageHistory.isEmpty
                        ? Center(
                            child: TextWidgets.generalText('No messages'),
                          )
                        : ListView(
                            children: controller.messageHistory.map((e) {
                              return TextWidgets.generalText(e);
                            }).toList(),
                          ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
