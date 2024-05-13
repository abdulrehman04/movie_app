import 'package:cowlar_task/presentation/mqtt/mqtt_client.dart';
import 'package:cowlar_task/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mqtt_client/mqtt_client.dart';

final MQTTViewModelProvider = ChangeNotifierProvider((ref) {
  return MQTTViewModel();
});

class MQTTViewModel extends ChangeNotifier {
  String connectionStatus = 'Disconnected';
  String topic = 'No Topic';

  TextEditingController messageController = TextEditingController();
  TextEditingController topicController = TextEditingController();
  List<String> messageHistory = [];

  final MQTTClient _client = MQTTClient();

  connectToServer() {
    _client.init('test.mosquitto.org', 'me', onConnected, onSubscribed);
  }

  disconnectServer() {
    _client.disconnect();
    connectionStatus = 'Disconnected';
    notifyListeners();
  }

  onConnected() {
    connectionStatus = 'Connected';
    notifyListeners();
  }

  onSubscribed(String topic) {
    this.topic = topicController.text.trim();
    notifyListeners();
    startMessageStream();
  }

  void connectDisconnectServer() {
    if (connectionStatus == 'Disconnected') {
      connectToServer();
    } else {
      disconnectServer();
    }
  }

  subscribeToTopic() {
    if (topicController.text.isEmpty) {
      Utils.showSnackbar(
        message: 'Cant subscribe to empty topic',
        isError: true,
      );
      return;
    }
    _client.subscribe(topicController.text.trim());
  }

  onSendMessage() {
    _client.sendMessage(messageController.text.trim());
    messageController.text = '';
  }

  void startMessageStream() {
    _client
        .getMessages()!
        .listen((List<MqttReceivedMessage<MqttMessage>> messages) {
      final MqttPublishMessage receivedMessage =
          messages[0].payload as MqttPublishMessage;
      final String message = MqttPublishPayload.bytesToStringAsString(
          receivedMessage.payload.message);

      messageHistory.add(message);
      notifyListeners();
    });
  }
}
