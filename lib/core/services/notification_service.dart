import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:mvvm_template/core/others/logger_customization/custom_logger.dart';
// import 'package:mvvm_template/core/services/authentication/firebase/fire_auth.dart';
// import 'package:mvvm_template/core/services/database/firestore/firebase_db_service.dart';
import 'package:mvvm_template/core/theme/app_colors.dart';
// import 'package:mvvm_template/locator.dart';

class NotificationsService {
  final log = CustomLogger(className: 'NotificationsService');
  final _awesomeNotifications = AwesomeNotifications();
  int get createUniqueId =>
      DateTime.now().millisecondsSinceEpoch.remainder(100000);
  // String? fcmToken;
  NotificationsService() {
    initNotifications();
    //requestPermission();
    clearAllNotifications();
    setListeners();
  }

  ///Intialize Awesome Nottifications
  initNotifications() {
    _awesomeNotifications.initialize(
      null,
      [
        NotificationChannel(
          channelGroupKey: 'tasks_channel_group',
          channelKey: 'tasks_channel',
          channelName: 'Tasks notifications',
          channelDescription: 'Notification channel for tasks',
          defaultColor: AppColors.primaryColor,
          importance: NotificationImportance.High,
          defaultRingtoneType: DefaultRingtoneType.Notification,
          channelShowBadge: true,
          playSound: true,
          enableVibration: true,
          ledColor: AppColors.whiteColor,
        ),
        NotificationChannel(
          channelGroupKey: 'appearance_channel_group',
          channelKey: 'appearance_channel',
          channelName: 'Appearance notifications',
          channelDescription: 'Notification channel for appearance',
          defaultColor: AppColors.primaryColor,
          importance: NotificationImportance.High,
          defaultRingtoneType: DefaultRingtoneType.Notification,
          channelShowBadge: true,
          playSound: true,
          enableVibration: true,
          ledColor: AppColors.whiteColor,
        )
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: 'tasks_channel_group',
          channelGroupName: 'Tasks group',
        ),
        NotificationChannelGroup(
          channelGroupKey: 'appearance_channel_group',
          channelGroupName: 'Appearance group',
        )
      ],
    );
  }

  ///Set all notification listeners
  setListeners() {
    _awesomeNotifications.setListeners(
      onActionReceivedMethod: _onActionReceivedMethod,
      onNotificationCreatedMethod: _onNotificationCreatedMethod,
      onNotificationDisplayedMethod: _onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: _onDismissActionReceivedMethod,
    );
  }

  ///Request Notification Permission
  requestPermission() async {
    bool isAllowed = await _awesomeNotifications.isNotificationAllowed();
    if (!isAllowed) {
      // This is just a basic example. For real apps, you must show some
      // friendly dialog box before call the request method.
      // This is very important to not harm the user experience
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  }

  ///Clears the badge and notification trey
  clearAllNotifications() {
    _awesomeNotifications.dismissAllNotifications();
    _awesomeNotifications.setGlobalBadgeCounter(0);
  }

  ///Create a notification
  ///notificationSchedule: The time at which you want to send Notification. Example: NotificationCalendar.fromDate(date: scheduleTime)
  ///category: Example NotificationCategory.Reminder
  createLocalNotification({
    required int id,
    required String channelKey,
    String? title,
    String? body,
    ActionType actionType = ActionType.Default,
    bool wakeUpScreen = false,
    NotificationSchedule? notificationSchedule,
    NotificationCategory? category,
    String summary = 'Notification',
    bool displayOnBackground = true,
    bool displayOnForeground = true,
  }) async {
    await _awesomeNotifications.createNotification(
      content: NotificationContent(
        id: id,
        channelKey: channelKey,
        title: title,
        body: body,
        summary: summary,
        actionType: actionType,
        wakeUpScreen: wakeUpScreen,
        category: category,
        displayOnBackground: displayOnBackground,
        displayOnForeground: displayOnForeground,
      ),
      schedule: notificationSchedule,
    );

    log.i('@createLocalNotification: Notification Created');
  }

  cancleScheduledNotification(int id) {
    _awesomeNotifications.cancelSchedule(id);
  }

  ///Cancels all the scheduled notifications on current device
  cancelAllNotifications() async {
    await _awesomeNotifications.cancelAll();
    log.i('@cancelAllNotifications: All Notifications Canceled');
  }

  ///Creates scheduled notifications for all the tasks on current device
  scheduleNotifications() async {
    // final dbService = locator<FirebaseService>();
    // final authService = locator<FireAuth>();
    // if (authService.currentUser != null) {
    //   List<Task> tasks =
    //       await dbService.getAllTasks(authService.currentUser!.uid);
    //   var now = DateTime.now();
    //   for (var task in tasks) {
    //     if (task.dueDate.isAfter(now)) {
    //       log.i(
    //           '@scheduleNotifications:Scheduling Notification for ${task.id}');
    //       await createLocalNotification(
    //         id: task.dueDate.millisecondsSinceEpoch.remainder(100000),
    //         channelKey: 'tasks_channel',
    //         title: 'Reminder',
    //         body: task.title,
    //         category: NotificationCategory.Reminder,
    //         wakeUpScreen: true,
    //         notificationSchedule: NotificationCalendar.fromDate(
    //           date: task.dueDate,
    //           preciseAlarm: true,
    //           allowWhileIdle: true,
    //         ),
    //       );
    //     }
    //   }

    //   List<Appearance> appearances =
    //       await dbService.getAllAppearances(authService.currentUser!.uid);
    //   for (var appearance in appearances) {
    //     if (appearance.startTime.isAfter(now)) {
    //       log.i(
    //           '@scheduleNotifications:Scheduling Notification for ${appearance.id}');
    //       await createLocalNotification(
    //         id: appearance.startTime.millisecondsSinceEpoch.remainder(100000),
    //         channelKey: 'appearance_channel',
    //         title: 'Reminder',
    //         body: appearance.title,
    //         category: NotificationCategory.Reminder,
    //         wakeUpScreen: true,
    //         notificationSchedule: NotificationCalendar.fromDate(
    //           date: appearance.startTime,
    //           preciseAlarm: true,
    //           allowWhileIdle: true,
    //         ),
    //       );
    //     }
    //   }
    // }
  }

  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> _onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> _onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> _onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> _onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here

    // Navigate into pages, avoiding to open the notification details page over another details page already opened
    // MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil('/notification-page',
    //         (route) => (route.settings.name != '/notification-page') || route.isFirst,
    //     arguments: receivedAction);
  }
}
