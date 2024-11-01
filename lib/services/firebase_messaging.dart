import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:gt_bank_app/main.dart';

class FirebaseMessagingAPI {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initializeFirebaseMessaging() async {
    // request permission from user (will prompt user)
    await _firebaseMessaging.requestPermission();

    //fetch the token for this device
    final fMToken = await _firebaseMessaging.getToken();

    print('Token:+$fMToken');

    initializePushNotifications();
  }

  void handleBackgroundMessaging(RemoteMessage? message) async {
    if (message == null) return;

    navigatorKey.currentState
        ?.pushNamed('/notifications_page', arguments: message);
  }

  Future initializePushNotifications() async {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then(handleBackgroundMessaging);

    FirebaseMessaging.onMessageOpenedApp.listen(handleBackgroundMessaging);
  }
}
