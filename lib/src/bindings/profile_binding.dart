import '../../../main_lib.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailProfileController>(() => DetailProfileController());
    Get.lazyPut<EditProfileController>(() => EditProfileController());
  }
}
