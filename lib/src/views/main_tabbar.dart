import 'package:core/core.dart';
import '../../../main_lib.dart';

class MainTabbar extends GetView<MainTabbarController> {
  const MainTabbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: SafeArea(
            child: Scaffold(
                appBar: AppBar(
                    automaticallyImplyLeading: false,
                    elevation: 0,
                    toolbarHeight: 54.w,
                    flexibleSpace: const MainTabbarHeaderComponents()),
                body: Stack(children: [
                  Image.asset(AssetsCollection.bg_lighter,
                      fit: BoxFit.cover,
                      width: Get.size.width,
                      height: Get.size.height),
                  Column(
                      children: const [Expanded(child: CustomTabViewModel())])
                ]))));
  }
}
