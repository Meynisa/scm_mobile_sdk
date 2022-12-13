import 'package:scm_mobile_sdk/main_lib.dart';

class CustomConfigController extends GetxController {
  static const platform = MethodChannel('flutter.native/helper');
  RxInt bgColorMsgSender = 0xFFBDB2CF.obs;
  RxInt bgColorMsgOwner = 0xFF873891.obs;
  RxInt lblColorMsgSender = 0xFF000000.obs;
  RxInt lblColorMsgOwner = 0xFFFFFFFF.obs;
  RxInt lblColorThemeDefault = 0xFFFFFFFF.obs;
  RxInt colorThemeDefault = 0xFF873891.obs;
  RxInt colorBtnSend = 0xFF873891.obs;
  RxString responseFontType = 'Ubuntu'.obs;
  Uint8List? uint8List;

  RxString clientKey = ''.obs;
  RxInt projectId = 0.obs;
  RxString ticketId = ''.obs;

  RxMap<String, dynamic> responseMap =
      {"color": '0xFFFFFFFF', "font": "Lato"}.obs;

  Future<void> _responseColorSenderFromNative() async {
    int response = 0xff453398;
    try {
      final int result = await platform.invokeMethod('bgColorMsgSender');
      response = result;
    } on PlatformException {
      response = 0xff982832;
    }
    bgColorMsgSender.value = response;
  }

  Future<void> _responseColorOwnerFromNative() async {
    int response = 0xff453398;
    try {
      final int result = await platform.invokeMethod('bgColorMsgOwner');
      response = result;
    } on PlatformException {
      response = 0xff982832;
    }
    bgColorMsgOwner.value = response;
  }

  Future<void> _responseColorThemeFromNative() async {
    int response = 0xff453398;
    try {
      final int result = await platform.invokeMethod('colorThemeDefault');
      response = result;
    } on PlatformException {
      response = 0xff982832;
    }
    colorThemeDefault.value = response;
  }

  Future<void> _responseColorBtnSendFromNative() async {
    int response = 0xff453398;
    try {
      final int result = await platform.invokeMethod('colorBtnSend');
      response = result;
    } on PlatformException {
      response = 0xff982832;
    }
    colorBtnSend.value = response;
  }

  Future<void> _responseLblColorSenderFromNative() async {
    int response = 0xff453398;
    try {
      final int result = await platform.invokeMethod('lblColorMsgSender');
      response = result;
    } on PlatformException {
      response = 0xff982832;
    }
    lblColorMsgSender.value = response;
  }

  Future<void> _responseLblColorOwnerFromNative() async {
    int response = 0xff453398;
    try {
      final int result = await platform.invokeMethod('lblColorMsgOwner');
      response = result;
    } on PlatformException {
      response = 0xff982832;
    }
    lblColorMsgOwner.value = response;
  }

  Future<void> _responseLblColorThemeFromNative() async {
    int response = 0xff453398;
    try {
      final int result = await platform.invokeMethod('lblColorThemeDefault');
      response = result;
    } on PlatformException {
      response = 0xff982832;
    }
    lblColorThemeDefault.value = response;
  }

  Future<void> _responseFontFromNative() async {
    String response = 'Lato';
    try {
      final String result = await platform.invokeMethod('fontFromNative');
      response = result;
    } on PlatformException {
      response = 'Lato';
    }
    responseFontType.value = response;
  }

  Future<void> _responseImgFromNative() async {
    Uint8List? response;
    try {
      final Uint8List result = await platform.invokeMethod('imageFromNative');
      response = result;
    } on PlatformException {
      response = null;
    }
    uint8List = response!;
    update();
  }

  Future<void> _responseMapFromNative() async {
    Map<String, String> response = <String, String>{};
    try {
      // var item = await platform.invokeMethod('mapFromNative');
      final Map<String, String> result = Map<String, String>.from(
          await platform.invokeMethod('mapFromNative'));
      response = result;
    } on PlatformException {
      response = <String, String>{};
    }
    responseMap.value = response;
  }

  Future<void> _responseClientKey() async {
    String response = '';
    try {
      final String result = await platform.invokeMethod('clientKey');
      response = result;
    } on PlatformException {
      response = '';
    }
    clientKey.value = response;
  }

  @override
  void onInit() {
    super.onInit();
    _responseColorOwnerFromNative();
    _responseColorSenderFromNative();
    _responseColorThemeFromNative();
    _responseColorBtnSendFromNative();
    _responseFontFromNative();
    _responseLblColorOwnerFromNative();
    _responseLblColorSenderFromNative();
    _responseLblColorThemeFromNative();
    _responseMapFromNative();
    _responseImgFromNative();
    _responseClientKey();
  }
}
