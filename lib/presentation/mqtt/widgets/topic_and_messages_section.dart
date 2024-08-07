part of '../mqtt_view.dart';

class TopicAndMessagesSection extends ConsumerWidget {
  const TopicAndMessagesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    MQTTViewModel controller = ref.watch(mqttViewModelProvider);
    return Column(
      children: [
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
        controller.topic == 'No Topic'
            ? TextWidgets.generalText('Please subscribe to a topic')
            : Expanded(
                child: Column(
                  children: [
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
              )
      ],
    );
  }
}
