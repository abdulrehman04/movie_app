import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MQTTClient {
  late MqttServerClient client;
  String? server, id, topic;

  MQTTClient();

  init(
    String server,
    String id,
    void Function()? onConnected,
    void Function(String topic)? onSubscribed,
  ) {
    client = MqttServerClient('test.mosquitto.org', 'Me');
    client.onConnected = onConnected;
    client.secure = false;
    client.onSubscribed = onSubscribed;
    client.connect();
  }

  sendMessage(String message) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    client.publishMessage(topic!, MqttQos.exactlyOnce, builder.payload!);
  }

  subscribe(String topic) {
    client.subscribe(topic, MqttQos.exactlyOnce);
    this.topic = topic;
  }

  Stream<List<MqttReceivedMessage<MqttMessage>>>? getMessages() {
    return client.updates;
  }

  void disconnect() {
    client.disconnect();
  }
}
