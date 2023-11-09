import 'package:firebase_messaging/firebase_messaging.dart';

Future<String> getDeviceToken() async {
  FirebaseMessaging firebaseMessage = FirebaseMessaging.instance;
  String? deviceToken = await firebaseMessage.getToken();
  return (deviceToken == null) ? "empty token" : deviceToken;
}
