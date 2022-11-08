import 'package:core/core.dart';
import '../../main_lib.dart';

class EditProfilePage extends GetView<EditProfileController> {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => dismissKeyboard(context),
        child: Scaffold(
            appBar: AppBar(
                title: Text('Change ${Get.arguments['type']}'),
                backgroundColor: ColorsCollection.cBgCardProfile,
                elevation: 0,
                toolbarHeight: 54.w,
                actions: [
                  IconButton(
                      onPressed: () => controller.saveChanges(),
                      icon: const Icon(Icons.check))
                ],
                leading: IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.close))),
            body: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(Get.arguments['type'],
                          style: body3().copyWith(color: Colors.black)),
                      const SizedBox(height: 16),
                      PrimaryTextfield(
                          keyboardType: TextInputType.number,
                          textEditingController: controller.textController,
                          radius: 25)
                    ]))));
  }
}
