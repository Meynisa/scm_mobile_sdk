import 'dart:io';
import '../../../main_lib.dart';

class NotificationController extends GetxController {
  AndroidNotificationChannel? channel;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  SocketController? _socketController;

  String darwinNotificationCategoryText = 'textCategory';
  String navigationActionId = 'id_3';
  String darwinNotificationCategoryPlain = 'plainCategory';
  final RxBool _notificationsEnabled = false.obs;

  void notificationTapBackground(NotificationResponse notificationResponse) {
    // ignore: avoid_print
    print('notification(${notificationResponse.id}) action tapped: '
        '${notificationResponse.actionId} with'
        ' payload: ${notificationResponse.payload}');
    if (notificationResponse.input?.isNotEmpty ?? false) {
      // ignore: avoid_print
      print(
          'notification action tapped with input: ${notificationResponse.input}');
    }
  }

  @override
  void onInit() async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    final List<DarwinNotificationCategory> darwinNotificationCategories =
        <DarwinNotificationCategory>[
      DarwinNotificationCategory(
        darwinNotificationCategoryText,
        actions: <DarwinNotificationAction>[
          DarwinNotificationAction.text(
            'text_1',
            'Action 1',
            buttonTitle: 'Send',
            placeholder: 'Placeholder',
          ),
        ],
      ),
      DarwinNotificationCategory(
        darwinNotificationCategoryPlain,
        actions: <DarwinNotificationAction>[
          DarwinNotificationAction.plain('id_1', 'Action 1'),
          DarwinNotificationAction.plain(
            'id_2',
            'Action 2 (destructive)',
            options: <DarwinNotificationActionOption>{
              DarwinNotificationActionOption.destructive,
            },
          ),
          DarwinNotificationAction.plain(
            navigationActionId,
            'Action 3 (foreground)',
            options: <DarwinNotificationActionOption>{
              DarwinNotificationActionOption.foreground,
            },
          ),
          DarwinNotificationAction.plain(
            'id_4',
            'Action 4 (auth required)',
            options: <DarwinNotificationActionOption>{
              DarwinNotificationActionOption.authenticationRequired,
            },
          ),
        ],
        options: <DarwinNotificationCategoryOption>{
          DarwinNotificationCategoryOption.allowAnnouncement,
        },
      )
    ];

    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {
        _onSelectNotification(payload!);
      },
      notificationCategories: darwinNotificationCategories,
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            _onSelectNotification(notificationResponse.payload!);
            break;
          case NotificationResponseType.selectedNotificationAction:
            if (notificationResponse.actionId == navigationActionId) {
              _onSelectNotification(notificationResponse.payload!);
            }
            break;
        }
      },
      // onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    _isAndroidPermissionGranted();

    if (!kIsWeb) _requestPermissions();

    super.onInit();
  }

  Future<void> _requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
            critical: true,
          );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
            critical: true,
          );
    } else if (Platform.isAndroid) {
      channel = const AndroidNotificationChannel(
          'high_importance_channel', // id
          'High Importance Notifications', // title
          description:
              'This channel is used for important notifications.', // description
          importance: Importance.max,
          playSound: false,
          enableVibration: true);

      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      await androidImplementation?.createNotificationChannel(channel!);

      final bool? granted = await androidImplementation?.requestPermission();

      _notificationsEnabled.value = granted ?? false;
    }
  }

  Future<void> _isAndroidPermissionGranted() async {
    if (Platform.isAndroid) {
      final bool granted = await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.areNotificationsEnabled() ??
          false;

      _notificationsEnabled.value = granted;
    }
  }

  Future<AndroidNotificationDetails> _getAndroidNotificationDetails() async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'General', 'General Notifications',
        channelDescription:
            'General notifications that are not sorted to any specific topics.',
        playSound: false,
        enableVibration: true,
        importance: Importance.high,
        priority: Priority.high,
        setAsGroupSummary: true,
        ticker: 'ticker');
    return androidPlatformChannelSpecifics;
  }

  Future<DarwinNotificationDetails> _getIosNotificationDetails() async {
    DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails(
      categoryIdentifier: darwinNotificationCategoryPlain,
    );
    return iosNotificationDetails;
  }

  void showNotification(StreamRows notification) async {
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        await _getAndroidNotificationDetails();
    var iOSPlatformChannelSpecifics = await _getIosNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    List<ImageContent>? image = notification.image == null
        ? null
        : [ImageContent(standard: notification.image![0].standard)];
    AudioContent? audio = notification.audio == null
        ? null
        : AudioContent(
            url: notification.audio!.url, title: notification.audio!.title);
    FileContent? file = notification.file == null
        ? null
        : FileContent(
            url: notification.file!.url, name: notification.file!.name);
    await flutterLocalNotificationsPlugin.show(
        0,
        notification.user!.name,
        '${notification.content}' == ""
            ? image != null
                ? 'Photo'
                : file != null
                    ? 'File'
                    : 'Audio'
            : notification.content,
        platformChannelSpecifics,
        payload: jsonEncode(notification.toJson()));
  }

  void _onSelectNotification(String payload) {
    _cancelAllNotifications();
    _socketController = Get.find<SocketController>();
    _socketController!.notificationOnSelect();
  }

  void notifUpdates(NewCommentData? commentData, String ticketId) {
    StreamRows item = StreamRows(
        id: ticketId,
        content: '${commentData!.content}' == 'null'
            ? commentData.replied ?? ''
            : '${commentData.content}',
        date: '${commentData.date}',
        image: commentData.image == null
            ? null
            : [ImageContent(standard: commentData.image!.standard)],
        audio: commentData.audio == null
            ? null
            : AudioContent(
                url: commentData.audio!.url, title: commentData.audio!.title),
        file: commentData.file == null
            ? null
            : FileContent(
                url: commentData.file!.url, name: commentData.file!.name),
        source: commentData.source,
        user: StreamUser(
            name: '${commentData.user!.name}',
            avatar: '${commentData.user!.avatar}'));

    commentData.source != 'chat' ? showNotification(item) : null;
  }

  Future<void> _cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
