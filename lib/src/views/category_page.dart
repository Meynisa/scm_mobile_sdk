import 'package:core/core.dart';
import '../../main_lib.dart';

class CategoryPage extends GetView<CategoryController> {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Add Tag Activity Code',
                style: subtitle1(), textAlign: TextAlign.center),
            IconButton(
                onPressed: () => controller.closeCategoryPageBtn(),
                icon: const Icon(Icons.close),
                padding: EdgeInsets.zero,
                alignment: Alignment.centerRight)
          ]),
          const SizedBox(height: 24),
          Text('Assign category to this ticket by selecting options below',
              style: body1()),
          const SizedBox(height: 24),
          SizedBox(
              width: Get.size.width / 4,
              height: 40,
              child: PrimaryButton(
                  color: Color(configController.colorThemeDefault.value),
                  title: 'Add',
                  textColor: Color(configController.lblColorThemeDefault.value),
                  trailingIcon: Icons.add,
                  trailingIconColor: Colors.white,
                  titleSize: 14.sp,
                  onTap: () => controller.addCategoryPageBtn())),
          const SizedBox(height: 24),
          Obx(() {
            return controller.pickedUpTag.isEmpty
                ? Container()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Wrap(
                            spacing: 5.0,
                            runSpacing: 3.0,
                            children: controller.pickedUpTag
                                .map((ActivityCode e) => SizedBox(
                                    width: Get.width / 3,
                                    child: _filterChip(
                                        e, controller.pickedUpTag.indexOf(e))))
                                .toList()
                                .cast<Widget>()),
                        const SizedBox(height: 24),
                        Align(
                            alignment: Alignment.center,
                            child: Obx(() {
                              return PrimaryButton(
                                  color: Color(
                                      configController.colorThemeDefault.value),
                                  textColor: Color(configController
                                      .lblColorThemeDefault.value),
                                  title: 'Submit',
                                  isLoading: controller.isLoading.value,
                                  onTap: () => controller.submitCategory());
                            }))
                      ]);
          })
        ]));
  }

  Future<void> categoryWidget() async {
    return showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const AlertDialog(
              contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              content: CategoryPage());
        });
  }

  FilterChip _filterChip(ActivityCode data, int idx) {
    return FilterChip(
        label: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(Icons.close,
                  size: 16, color: ColorsCollection.cPurple),
              const SizedBox(width: 3),
              Expanded(
                  child: Text('${data.code!} ${data.description!}',
                      overflow: TextOverflow.ellipsis,
                      style: body1().copyWith(color: Colors.black)))
            ]),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: const BorderSide(color: ColorsCollection.cPurple)),
        backgroundColor: Colors.white,
        onSelected: (isSelected) => controller.pickedUpTag.removeAt(idx),
        selectedColor: const Color(0xffeadffd),
        disabledColor: ColorsCollection.cDisableColor);
  }
}
