import 'dart:io';
import 'package:core/core.dart';
import '../../main_lib.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => dismissKeyboard(context),
        child: Scaffold(
            body: Stack(children: [
          Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.5, 1],
                          colors: [Color(0xFFB163FF), Color(0xFF5D58FF)])),
                  child: SvgPicture.asset(AssetsCollection.bg_texture_svg,
                      fit: BoxFit.cover,
                      width: Get.size.width,
                      height: Get.size.height))),
          Center(
              child: SingleChildScrollView(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _logoWidget(),
                        const SizedBox(height: 50),
                        _fieldWidget(),
                        const SizedBox(height: 50),
                        _bottomWidget()
                      ])))
        ])));
  }

  Widget _logoWidget() {
    return Column(children: [
      configController.uint8List == null
          ? Container()
          : Container(
              width: Get.width / 5,
              height: Get.width / 5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                      color: Colors.black38, style: BorderStyle.solid),
                  image: DecorationImage(
                      image: FileImage(
                          File.fromRawPath(configController.uint8List!)),
                      fit: BoxFit.cover))),
      Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          padding: const EdgeInsets.all(8),
          child: Image.asset(AssetsCollection.scm_icon,
              fit: BoxFit.fitWidth, width: Get.size.width / 7)),
      const SizedBox(height: 15),
      Text('Application for Agent',
          style: body3()
              .copyWith(color: Colors.white, fontWeight: FontWeight.w500))
    ]);
  }

  Widget _fieldWidget() {
    return Column(children: [
      Text(DictionaryUtil.login[0].tr,
          style: GoogleFonts.getFont(configController.responseMap.value["font"])
              .copyWith(
                  color: Color(
                      int.parse(configController.responseMap.value["color"])),
                  fontSize: 28)), //headline2().copyWith(color: Colors.white)),
      const SizedBox(height: 24),
      AutofillGroup(
          child: Column(children: [
        PrimaryTextfield(
            textEditingController: controller.emailController,
            textHint: DictionaryUtil.email.tr,
            validator: (value) => controller.validateEmail(value!),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.emailAddress,
            textCapitalization: TextCapitalization.none,
            autofillType: const [AutofillHints.email],
            // labelText: 'Email',
            scrollPadding: 200,
            radius: 50),
        const SizedBox(height: 15),
        PrimaryTextfield(
            textEditingController: controller.passwordController,
            textHint: DictionaryUtil.password.tr,
            validator: (value) => controller.validatePassword(value!),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.text,
            textFieldType: TextFieldType.PASSWORD,
            textCapitalization: TextCapitalization.none,
            isVisible: true,
            autofillType: const [AutofillHints.password],
            // labelText: 'Password',
            scrollPadding: 200,
            radius: 50),
        const SizedBox(height: 30),
        Obx(() {
          return PrimaryButton(
              title: DictionaryUtil.login_btn.tr,
              color: ColorsCollection.cBlue,
              isLoading: controller.isSubmit.value,
              cornerRadius: 16,
              onTap: controller.submitOnPressedBtn());
        })
      ]))
    ]);
  }

  Widget _bottomWidget() {
    return Column(children: [
      Text('v ${DictionaryUtil.app_version}',
          style: body7().copyWith(color: Colors.white)),
      Text('©2022 Ivosights',
          textAlign: TextAlign.center,
          style: body7().copyWith(color: Colors.white))
    ]);
  }
}
