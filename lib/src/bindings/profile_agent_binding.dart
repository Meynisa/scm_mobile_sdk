import '../../../main_lib.dart';

class ProfileAgentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileAgentController>(() => ProfileAgentController());
  }
}
