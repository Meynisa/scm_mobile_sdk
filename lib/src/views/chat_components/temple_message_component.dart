import 'package:core/core.dart';
import '../../../main_lib.dart';

class TemplateMessageComponent extends GetView<TemplateMessageController> {
  const TemplateMessageComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void templeBottomSheet(BuildContext context) async {
    await Get.bottomSheet(
            GestureDetector(
                onTap: () => dismissKeyboard(context),
                child: Container(
                    color: Colors.transparent,
                    child: Container(
                        height: Get.size.height / 3,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0))),
                        child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(children: [
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
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextButton.icon(
                                        onPressed: () {},
                                        icon: const Icon(
                                            Icons.text_fields_rounded,
                                            color: ColorsCollection.cPurple),
                                        label: Text('Template Message',
                                            style: subtitle7().copyWith(
                                                color: Colors.black))),
                                    IconButton(
                                        onPressed: () => Get.back(),
                                        icon: const Icon(Icons.close_rounded))
                                  ]),
                              const Divider(),
                              controller.listTemplate!.value.isEmpty
                                  ? AlertDialogCustom().emptyWidget()
                                  : Expanded(
                                      child: ListView.builder(
                                          itemCount: controller
                                              .listTemplate!.value.length,
                                          itemBuilder: (_, index) => Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Obx(() {
                                                      return Radio<int?>(
                                                          value: controller
                                                              .listTemplate!
                                                              .value[index]
                                                              .isChecked,
                                                          groupValue: controller
                                                              .radioDateValue
                                                              .value,
                                                          onChanged: (value) {
                                                            controller
                                                                .handleTemplateToogle(
                                                                    value!,
                                                                    index);
                                                          });
                                                    }),
                                                    Text(
                                                        controller.listTemplate!
                                                            .value[index].name!,
                                                        style: body1())
                                                  ])))
                            ]))))),
            isScrollControlled: true)
        .then((value) {
      controller.dismissedBottomSheet();
    });
  }
}
