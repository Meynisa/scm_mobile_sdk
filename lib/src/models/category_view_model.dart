import 'package:core/core.dart';
import '../../main_lib.dart';

class CategoryViewModel extends GetView<CategoryController> {
  const CategoryViewModel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            title: Text('List Category', style: subtitle1()),
            centerTitle: true,
            leading: IconButton(
                alignment: Alignment.centerLeft,
                onPressed: () => controller.backOnTapped(),
                icon: const Icon(Icons.arrow_back_ios))),
        body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            children: [
              Obx(() {
                return Column(children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.listCategories.length,
                      itemBuilder: (_, index) =>
                          _listItem(controller.listCategories[index], index)),
                  controller.isLoading.value
                      ? AlertDialogCustom().loadingProgressIndicator()
                      : Container(),
                  controller.isSavedCategory.value
                      ? SizedBox(
                          width: Get.size.width / 4,
                          child: PrimaryButton(
                              color: Color(
                                  configController.colorThemeDefault.value),
                              title: 'Add',
                              textColor: Color(
                                  configController.lblColorThemeDefault.value),
                              trailingIcon: Icons.add,
                              trailingIconColor: Colors.white,
                              titleSize: 14.sp,
                              onTap: () => controller.addCategoryBtn()))
                      : Container()
                ]);
              })
            ]));
  }

  _listItem(List<ActivityCode> data, int index) {
    return DropdownButton<ActivityCode>(
      hint: const SizedBox(
          width: 150,
          child: Text("Select Item Type",
              style: TextStyle(color: Colors.grey), textAlign: TextAlign.end)),
      menuMaxHeight: Get.size.height / 3,
      value: controller.listDropdownValue[index],
      isExpanded: true,
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 16,
      onChanged: (ActivityCode? newValue) =>
          controller.dropDownOnChanged(newValue!, index),
      items: data.map<DropdownMenuItem<ActivityCode>>((ActivityCode value) {
        return DropdownMenuItem<ActivityCode>(
            value: value, child: Text('${value.code} ${value.description}'));
      }).toList(),
    );
  }
}
