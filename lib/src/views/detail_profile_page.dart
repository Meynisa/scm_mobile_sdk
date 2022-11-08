import 'package:core/core.dart';
import '../../main_lib.dart';

class DetailProfilePage extends GetView<DetailProfileController> {
  const DetailProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsCollection.cBgProfile,
        appBar: AppBar(
            backgroundColor: ColorsCollection.cBgCardProfile,
            elevation: 0,
            toolbarHeight: 54.w,
            leading: IconButton(
                onPressed: () => controller.getBack(),
                icon: const Icon(Icons.arrow_back_ios))),
        body: Center(
            child: SingleChildScrollView(
                child: Column(children: [
          _headerProfile(),
          const SizedBox(height: 8),
          Container(
              width: Get.size.width,
              color: ColorsCollection.cBgCardProfile,
              padding: const EdgeInsets.all(16),
              child: _contactListWidget()),
          const SizedBox(height: 8),
          Container(
              width: Get.size.width,
              color: ColorsCollection.cBgCardProfile,
              padding: const EdgeInsets.all(16),
              child: _customListWidget()),
          const SizedBox(height: 16)
        ]))));
  }

  Container _headerProfile() {
    return Container(
        width: Get.size.width,
        color: ColorsCollection.cBgCardProfile,
        child: Obx(() {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PlaceholderWidget(
                    imgAssets: controller.item.value.user!.avatar, size: 100),
                const SizedBox(height: 18),
                Text('${controller.item.value.user!.name}', style: headline3()),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text('${controller.item.value.totalTicket} Tickets . ',
                      style: subtitle7()
                          .copyWith(color: ColorsCollection.cDarkGrey)),
                  Text(
                      '${controller.item.value.user!.channels!.isEmpty ? 0 : controller.item.value.user!.channels![0].followersCount} Followers . ',
                      style: subtitle7()
                          .copyWith(color: ColorsCollection.cDarkGrey)),
                  Text(
                      '${controller.item.value.user!.channels!.isEmpty ? 0 : controller.item.value.user!.channels![0].friendsCount} Following',
                      style: subtitle7()
                          .copyWith(color: ColorsCollection.cDarkGrey))
                ]),
                const SizedBox(height: 24)
              ]);
        }));
  }

  Widget _contactListWidget() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Contact Info', style: subtitle6()),
      const SizedBox(height: 8),
      _defaultContactWidget('Name', '${controller.item.value.user!.name}'),
      _defaultContactWidget('Email', '${controller.item.value.user!.email}'),
      _defaultContactWidget(
          'Phone Number', '${controller.item.value.user!.phone}'),
      const SizedBox(height: 16),
      SizedBox(
          height: controller.listHeight(
              controller.item.value.customContactField!.length,
              contacts: controller.item.value.customContactField!),
          child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.item.value.customContactField!.length,
              itemBuilder: (_, index) {
                int idx = controller.indexValue(
                    controller.item.value.customContactField![index]);
                return _customContactField(
                    controller.item.value.customContactField![index].label!,
                    controller.customContactValue(
                        controller.item.value.customContactField![index]),
                    type: ProfileUserConverter().convertProfileType(
                        controller.item.value.customContactField![index].type!),
                    customContactField:
                        controller.item.value.customContactField![index],
                    indexDropDown: idx,
                    index: index);
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 16);
              }))
    ]);
  }

  Widget _customListWidget() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Custom Ticket Field', style: subtitle6()),
      const SizedBox(height: 16),
      SizedBox(
          height: controller.listHeight(
              controller.item.value.customFields!.length,
              customs: controller.item.value.customFields!,
              isContact: false),
          child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.item.value.customFields!.length,
              itemBuilder: (_, index) {
                int idx = controller.indexCustomValue(
                    controller.item.value.customFields![index]);
                return _customContactField(
                    controller.item.value.customFields![index].label!,
                    controller.item.value.customFields![index].value,
                    type: ProfileUserConverter().convertProfileType(
                        controller.item.value.customFields![index].type!),
                    customFields: controller.item.value.customFields![index],
                    customList: true,
                    indexDropDown: idx,
                    index: index);
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 16);
              }))
    ]);
  }

  Widget _customContactField(String? title, String? value,
      {ProfileType? type,
      CustomContactField? customContactField,
      CustomFields? customFields,
      int? indexDropDown,
      int? index,
      bool? customList = false}) {
    if (type == ProfileType.select) {
      return customList == true
          ? _customFieldDropdownWidget(title, value, customFields!.options,
              indexDropDown!, index!, customFields.name)
          : _customContactDropdownWidget(value, customContactField!.options,
              indexDropDown!, index!, customContactField);
    } else {
      return customList == true
          ? _inputTypeWidget(title, value, type,
              isContact: false, keyName: customFields!.name ?? '', index: index)
          : _inputTypeWidget(title, value, type,
              customContactField: customContactField, index: index);
    }
  }

  Widget _customContactDropdownWidget(String? value, List<String>? items,
      int indexDropdown, int index, CustomContactField customContactField) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(customContactField.label!,
          style: body1().copyWith(color: Colors.black)),
      Obx(() {
        return DropdownViewModel(
            value: controller.listStringValue.value[indexDropdown],
            onChanged: (String? newValue) => controller.dropdownOnChangedValue(
                newValue!, index, indexDropdown, customContactField),
            items: items);
      })
    ]);
  }

  Widget _customFieldDropdownWidget(
      String? label,
      String? value,
      List<CustomOptions>? items,
      int indexDropdown,
      int index,
      String? keyName) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label!, style: body1().copyWith(color: Colors.black)),
      Obx(() {
        return DropdownButton<CustomOptions>(
            menuMaxHeight: Get.size.height / 3,
            value: controller.listOptionsValue.value[indexDropdown],
            isExpanded: true,
            icon: const Icon(Icons.arrow_drop_down),
            elevation: 16,
            onChanged: (CustomOptions? newValue) =>
                controller.dropdownOnChangedOptionsValue(
                    newValue!, index, indexDropdown, keyName),
            items: items!
                .map<DropdownMenuItem<CustomOptions>>((CustomOptions value) {
              return DropdownMenuItem<CustomOptions>(
                  value: value,
                  child: Text('${value.display}', style: body1()));
            }).toList());
      })
    ]);
  }

  Widget _inputTypeWidget(String? title, String? value, ProfileType? type,
      {String? keyName,
      bool? isContact = true,
      CustomContactField? customContactField,
      int? index}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title!, style: body1().copyWith(color: Colors.black)),
      const SizedBox(height: 16),
      PrimaryTextfield(
          textHint: value,
          keyboardType: ProfileUserConverter().convertKeyboardType(type!),
          textInputAction: TextInputAction.done,
          textInputFormatter: type == ProfileType.number
              ? [FilteringTextInputFormatter.digitsOnly]
              : null,
          onFieldSubmitted: (value) => isContact!
              ? controller.editCustomContactField(
                  customContactField!, value, index!)
              : controller.editCustomField(keyName!, value, index!),
          maxLine: type == ProfileType.textarea ? 4 : 1)
    ]);
  }

  Widget _defaultContactWidget(String? title, String? value) {
    return InkWell(
        onTap: () => controller.editValues(title, value),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 16),
          Text(title!, style: body1().copyWith(color: Colors.black)),
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
                        value == null || value == '' || title == 'Phone Number'
                            ? const Icon(Icons.arrow_forward_ios_rounded,
                                color: Colors.black)
                            : Container()
                      ])))
        ]));
  }
}
