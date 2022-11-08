import 'package:core/core.dart';
import '../../main_lib.dart';

class FilterViewModel extends GetView<FilterController> {
  const FilterViewModel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void filterMenuBottomSheet(BuildContext context) async {
    await Get.bottomSheet(
        GestureDetector(
            onTap: () => dismissKeyboard(context),
            child: Container(
                color: Colors.transparent,
                child: Container(
                    height: 2 * (Get.size.height / 3),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0))),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Stack(children: [
                          Column(children: [
                            const SizedBox(height: 16.0),
                            Center(
                                child: Container(
                                    height: 5,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        color: ColorsCollection.cLightGrey))),
                            const SizedBox(height: 8.0),
                            Expanded(
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                  TextButton.icon(
                                      onPressed: () {},
                                      icon: const Icon(Icons.filter_list,
                                          color: Colors.black),
                                      label: Text('Filter',
                                          style: subtitle7()
                                              .copyWith(color: Colors.black))),
                                  TextButton(
                                      onPressed: () => controller.resetFilter(),
                                      child: Text('Reset',
                                          style: subtitle7()
                                              .copyWith(color: Colors.black)))
                                ])),
                            const SizedBox(height: 8.0)
                          ]),
                          Positioned(
                              left: 0,
                              right: 0,
                              top: 70,
                              bottom: 70,
                              child: SingleChildScrollView(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                    const Divider(),
                                    _filterHeadline(
                                        'Search', Icons.search_rounded),
                                    Obx(() {
                                      return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                          child: DropdownViewModel(
                                              value: controller
                                                  .searchDropdownValue.value,
                                              onChanged: (String? newValue) =>
                                                  controller
                                                      .searchOnChangedValue(
                                                          newValue!),
                                              items: controller
                                                  .searchDropdownItems));
                                    }),
                                    const SizedBox(height: 16.0),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text('Keyword', style: body1()),
                                              const SizedBox(height: 8.0),
                                              PrimaryTextfield(
                                                  textFieldHeight: 40,
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  textCapitalization:
                                                      TextCapitalization.none,
                                                  textEditingController:
                                                      controller
                                                          .searchByController,
                                                  scrollPadding: 200)
                                            ])),
                                    const SizedBox(height: 16.0),
                                    _filterHeadline(
                                        'Date', Icons.date_range_rounded),
                                    Container(
                                        height:
                                            controller.rangeFilterInfo.length *
                                                47,
                                        padding: EdgeInsets.zero,
                                        margin: EdgeInsets.zero,
                                        child: ListView.builder(
                                            padding: EdgeInsets.zero,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemBuilder: (content, index) {
                                              return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Obx(() {
                                                      return Radio(
                                                          value: controller
                                                              .rangeFilterInfo[
                                                                  index]
                                                              .isActivated,
                                                          groupValue: controller
                                                              .radioDateValue
                                                              .value,
                                                          onChanged: (value) =>
                                                              controller
                                                                  .handleDateRadioValueChanges(
                                                                      value));
                                                    }),
                                                    Text(
                                                        controller
                                                            .rangeFilterInfo[
                                                                index]
                                                            .title
                                                            .tr,
                                                        style: body1())
                                                  ]);
                                            },
                                            itemCount: controller
                                                .rangeFilterInfo.length)),
                                    Obx(() {
                                      return controller.radioDateValue.value ==
                                              5
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16.0),
                                              child: Row(children: [
                                                Obx(() {
                                                  return Text(
                                                      '${controller.getFrom()} - ${controller.getUntil()}',
                                                      style: body3().copyWith(
                                                          color:
                                                              ColorsCollection
                                                                  .cDarkGrey));
                                                }),
                                                TextButton(
                                                    onPressed: () => controller
                                                        .showRangePicker(),
                                                    child: Text(
                                                        DictionaryUtil
                                                            .change.tr,
                                                        style: body1().copyWith(
                                                            color:
                                                                ColorsCollection
                                                                    .cPurple)))
                                              ]))
                                          : Container();
                                    }),
                                    _filterHeadline(
                                        'Sort', Icons.sort_by_alpha_rounded),
                                    Obx(() {
                                      return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                          child: DropdownViewModel(
                                              value: controller
                                                  .sortDropdownValue.value,
                                              onChanged: (String? newValue) =>
                                                  controller.sortOnChangedValue(
                                                      newValue!),
                                              items: controller
                                                  .sortDropdownItems));
                                    }),
                                    Container(
                                        height:
                                            controller.listSortRadioBtn.length *
                                                47,
                                        padding: EdgeInsets.zero,
                                        margin: EdgeInsets.zero,
                                        child: ListView.builder(
                                            padding: EdgeInsets.zero,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemBuilder: (content, index) {
                                              return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Obx(() {
                                                      return Radio(
                                                          value: controller
                                                              .listSortRadioBtn[
                                                                  index]
                                                              .isActivated,
                                                          groupValue: controller
                                                              .sortRadioValue
                                                              .value,
                                                          onChanged: (value) =>
                                                              controller
                                                                  .handleSortRadioValueChanges(
                                                                      value));
                                                    }),
                                                    Text(
                                                        controller
                                                            .listSortRadioBtn[
                                                                index]
                                                            .title
                                                            .tr,
                                                        style: body1())
                                                  ]);
                                            },
                                            itemCount: controller
                                                .listSortRadioBtn.length))
                                  ]))),
                          Positioned(
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 5.0,
                                      right: 5.0,
                                      bottom: 16.0,
                                      top: 8),
                                  width: Get.size.width,
                                  height: 70,
                                  child: PrimaryButton(
                                      title: DictionaryUtil.apply.tr,
                                      onTap: () =>
                                          controller.handleApplyFilter(),
                                      color: ColorsCollection.cPurple)))
                        ]))))),
        isScrollControlled: true);
  }

  Widget _filterHeadline(String title, IconData icon) {
    return Column(children: [
      const SizedBox(height: 16.0),
      Row(children: [
        Icon(icon),
        const SizedBox(width: 8),
        Text(title, style: subtitle7())
      ]),
      const SizedBox(height: 8.0),
      const Divider()
    ]);
  }
}
