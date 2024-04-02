import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: $message.notification.title');
}

class firebaseNotification {
  final _firebaseNotification = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseNotification.requestPermission();
    final fCMToken = await _firebaseNotification.getToken();
    print("token $fCMToken");
    try {
      FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
      Future<void> enableForegroundMessage() async {
        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
          print('Got a message whilst in the foreground!');
          print('Message data: ${message.data}');

          if (message.notification != null) {
            print(
                'Message also contained a notification: ${message.notification}');
          }
        });
      }
    } catch (e) {
      print("error $e");
    }
  }
}
