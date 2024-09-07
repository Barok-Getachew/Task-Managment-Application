import '../models/task.dart';
import '../utils/app_exports.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  // Initialize the notification settings
  static Future<void> init() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _notifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notficationResponse) async {},
    );
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max));
  }

  Future showNotfication({required Task task}) async {
    return _notifications.show(task.id!, 'New Task Added',
        'Task Name:${task.title}', await notificationDetails());
  }

  static Future<void> _onSelectNotification(String? payload) async {
    if (payload != null) {
      // Use GetX for navigation or any other method to navigate to the task screen
      Get.toNamed('/home', arguments: {'taskId': int.parse(payload)});
    }
  }
}
