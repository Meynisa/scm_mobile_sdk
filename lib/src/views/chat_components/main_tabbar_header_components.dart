import 'package:core/core.dart';
import '../../../main_lib.dart';

class MainTabbarHeaderComponents extends GetView<MainTabbarController> {
  const MainTabbarHeaderComponents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [_appBarLeading(), _appBarActions()])));
  }

  Widget _appBarLeading() {
    return Row(children: [
      Image.asset(AssetsCollection.scm_icon, fit: BoxFit.cover, width: 24.w),
      const SizedBox(width: 10),
      Text(DictionaryUtil.ticket.tr,
          style: headline3().copyWith(
              color: const Color(0xFF212121), fontWeight: FontWeight.w500))
    ]);
  }

  Widget _appBarActions() {
    return Row(children: [
      IconButton(
          onPressed: () =>
              const FilterViewModel().filterMenuBottomSheet(Get.context!),
          icon: Icon(Icons.search, size: 24.w, color: Colors.black)),
      Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: InkWell(
              onTap: () => Get.toNamed(AppPages.PROFILE_AGENT),
              child: PlaceholderWidget(
                  size: 24.w,
                  imgAssets: controller.meData!.avatar,
                  imgPlaceholder: AssetsCollection.ic_avatar)))
    ]);
  }
}
