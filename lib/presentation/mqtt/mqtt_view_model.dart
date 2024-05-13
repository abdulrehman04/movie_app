import 'package:cowlar_task/presentation/mqtt/mqtt_client.dart';
import 'package:cowlar_task/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mqtt_client/mqtt_client.dart';

final mqttViewModelProvider = ChangeNotifierProvider((ref) {
  return MQTTViewModel();
});

class MQTTViewModel extends ChangeNotifier {
  bool connected = false;
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
    connected = false;
    notifyListeners();
  }

  onConnected() {
    connected = true;
    notifyListeners();
  }

  onSubscribed(String topic) {
    this.topic = topicController.text.trim();
    notifyListeners();
    startMessageStream();
  }

  void connectDisconnectServer() {
    if (!connected) {
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
