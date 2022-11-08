import 'package:core/core.dart';
import 'package:scm_mobile_sdk/main_lib.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == 'uniqueKey') {
      ///do the task in Backend for how and when to send notification

      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails('your channel id', 'your channel name',
              channelDescription:
                  'General notifications that are not sorted to any specific topics.',
              importance: Importance.max,
              priority: Priority.high,
              showWhen: false);
      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
    }
    return Future.value(true);
  });
}

void main() async {
  FlavorConfig(
      flavor: Flavor.DEV,
      values: FlavorValues(
          baseUrl: Endpoint.baseUrlDev, socketUrl: Endpoint.socketUrlDev));
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
  Workmanager().registerPeriodicTask(
    "2",
    "uniqueKey",
    frequency: const Duration(minutes: 15),
  );
  // await Firebase.initializeApp().whenComplete(() async {
  await GetStorage.init();

  runApp(const MyApp());
  // });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.black, // navigation bar color
        statusBarIconBrightness: Brightness.dark, // status bar icons' color
        systemNavigationBarIconBrightness: Brightness.light));
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeService().theme,
            getPages: AppPages.routes,
            home: const SplashScreen(),
            // navigatorObservers: [
            //   // SentryNavigatorObserver(),
            //   AnalyticsService().getAnalyticsObserver()
            // ],
            locale: LocalizationService().loadLanguages(),
            fallbackLocale: const Locale('en', 'US'),
            translationsKeys: LocalizationService.translationKeys,
            builder: (context, widget) => MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
                child: widget!)));
  }
}
