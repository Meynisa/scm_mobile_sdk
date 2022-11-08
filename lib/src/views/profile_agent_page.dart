import 'package:core/core.dart';
import '../../main_lib.dart';

class ProfileAgentPage extends GetView<ProfileAgentController> {
  const ProfileAgentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsCollection.cBgProfile,
        appBar: AppBar(
            backgroundColor: ColorsCollection.cBgCardProfile,
            elevation: 0,
            toolbarHeight: 54.w,
            leading: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.arrow_back_ios))),
        body: SingleChildScrollView(
            child: Column(children: [
          Container(
              width: Get.size.width,
              color: ColorsCollection.cBgCardProfile,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PlaceholderWidget(
                        size: 100, imgAssets: controller.meData!.avatar),
                    const SizedBox(height: 18),
                    Text('${controller.meData!.name}', style: headline3()),
                    Text('${controller.meData!.level}',
                        style: subtitle7()
                            .copyWith(color: ColorsCollection.cDarkGrey)),
                    const SizedBox(height: 24)
                  ])),
          const SizedBox(height: 8),
          Container(
              width: Get.size.width,
              color: ColorsCollection.cBgCardProfile,
              padding: const EdgeInsets.all(16),
              child: _columnField()),
          const SizedBox(height: 16)
        ])));
  }

  Widget _columnField() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Contact Info', style: subtitle7()),
          const SizedBox(height: 8),
          _contactField('Name', '${controller.meData!.name}'),
          _contactField('Email', '${controller.meData!.email}'),
          const SizedBox(height: 24),
          Center(
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: ColorsCollection.cPurple),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0))),
                  width: Get.size.width / 3,
                  child: _popupMethod())),
          const SizedBox(height: 16),
          PrimaryButton(title: 'Logout', onTap: () => controller.logoutEvent())
        ]);
  }

  PopupMenuButton<String> _popupMethod() {
    return PopupMenuButton<String>(
        onSelected: (String value) => controller.buttonEvent(value),
        icon: Obx(() {
          return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 2,
                    child: Text(controller.dataChanges.value.capitalizeFirst!,
                        textAlign: TextAlign.center,
                        style: body1().copyWith(color: Colors.black))),
                const Expanded(
                    child: Icon(Icons.arrow_drop_down,
                        color: ColorsCollection.cPurple))
              ]);
        }),
        itemBuilder: (BuildContext context) => controller.statusAppBar
            .map((String value) => PopupMenuItem<String>(
                value: value,
                child: Text(value.capitalizeFirst!, style: body1())))
            .toList());
  }

  Widget _contactField(String title, String? value) {
    return InkWell(
        onTap: () {},
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 16),
          Text(title, style: body3().copyWith(color: Colors.black)),
          Container(
              width: Get.size.width,
              padding: const EdgeInsets.only(top: 8),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: ColorsCollection.cDarkGrey))),
              child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(value ?? '',
                            style: subtitle7().copyWith(color: Colors.black)),
                        value == null || value == ''
                            ? const Icon(Icons.arrow_forward_ios_rounded,
                                color: Colors.black)
                            : Container()
                      ])))
        ]));
  }
}
