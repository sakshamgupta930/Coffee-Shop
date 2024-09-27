import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: $message.notification.title');
}

class FirebaseNotification {
  final _firebaseNotification = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseNotification.requestPermission();
    final fCMToken = await _firebaseNotification.getToken();
    print("token $fCMToken");
    try {
      FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    } catch (e) {
      print("error $e");
    }
  }
}
