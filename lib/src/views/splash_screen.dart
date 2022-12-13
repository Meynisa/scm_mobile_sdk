import 'package:core/core.dart';
import 'package:scm_mobile_sdk/main_lib.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () async {
      PreferenceUtils().setUserToken(configController.clientKey.value);
      Get.offNamed(AppPages.CHAT_ROOM);
    });
    return Scaffold(
        body: Stack(children: [
      Center(
          child: Padding(
              padding: const EdgeInsets.all(80),
              child: Image.asset(AssetsCollection.scm_logo,
                  fit: BoxFit.fitWidth, width: Get.size.width / 1.2))),
      Positioned(
          left: 0,
          right: 0,
          bottom: 40,
          child: Text('©2022 Ivosights',
              textAlign: TextAlign.center, style: body7()))
    ]));
  }
}
