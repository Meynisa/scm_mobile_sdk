import 'package:core/core.dart';
import '../../../main_lib.dart';

class DetailProfileController extends GetxController with StateMixin {
  final ChatRepository _chatRepository = ChatRepositoryImpl();
  var item = TicketData().obs;
  RxList<String?> listStringValue = RxList<String>();
  RxList<CustomOptions?> listOptionsValue = RxList<CustomOptions>();
  RxString dropdownValue = "".obs;
  int index = 0;
  int indexCustom = 0;
  int tempCustom = 0;
  int temp = 0;

  @override
  void onInit() {
    TicketData data = TicketData.fromJson(
        PreferenceUtils().getFromPreferences(StringPreferences.ticketData) ??
            Get.arguments);
    item.value = data; //TicketData.fromJson(Get.arguments);
    printInfo(info: PreferenceUtils().getUserToken().toString());
    optionsValueUpdate();
    super.onInit();
  }

  getBack() {
    TicketData ticketData = TicketData(
      id: item.value.id,
      user: TicketUser(
          avatar: item.value.user!.avatar,
          id: item.value.user!.id,
          email: item.value.user!.email,
          name: item.value.user!.name,
          phone: item.value.user!.phone,
          channels: item.value.user!.channels,
          customContactField: item.value.user!.customContactField,
          customField: item.value.user!.customField),
      totalTicket: item.value.totalTicket,
      customContactField: item.value.customContactField,
      customFields: item.value.customFields,
    );
    PreferenceUtils()
        .saveToPreferences(StringPreferences.ticketData, ticketData.toJson());
    Get.back();
  }

  void editValues(String title, String? value) {
    if (value == null || value == '' || title == 'Phone Number') {
      Get.toNamed(AppPages.EDIT_PROFILE,
          arguments: {'type': title, 'value': value});
    }
  }

  void dropdownOnChangedValue(String? newValue, int index, int indexDropdown,
      CustomContactField customContactField) {
    listStringValue[indexDropdown] = newValue!;

    editCustomContactField(customContactField, newValue, index);
  }

  void dropdownOnChangedOptionsValue(
      CustomOptions? newValue, int index, int indexDropdown, String? keyName) {
    listOptionsValue[indexDropdown] = newValue!;

    editCustomField(keyName!, newValue.value!, index);
  }

  void optionsValueUpdate() {
    for (CustomFields value in item.value.customFields!) {
      if (ProfileUserConverter().convertProfileType(value.type!) ==
          ProfileType.select) {
        if (value.value != "") {
          for (CustomOptions item in value.options!) {
            if (item.value == value.value) {
              listOptionsValue.add(item);
            }
          }
        } else {
          listOptionsValue.add(value.options![0]);
        }
      }
    }

    for (CustomContactField value in item.value.customContactField!) {
      if (ProfileUserConverter().convertProfileType(value.type!) ==
          ProfileType.select) {
        listStringValue
            .add(value.value == '' ? value.options![0] : value.value);
      }
    }
  }

  int indexValue(CustomContactField value) {
    if (ProfileUserConverter().convertProfileType(value.type!) ==
        ProfileType.select) {
      index = temp == 0 ? 0 : index + 1;
      temp++;
    }

    return index;
  }

  int indexCustomValue(CustomFields value) {
    if (ProfileUserConverter().convertProfileType(value.type!) ==
        ProfileType.select) {
      indexCustom = tempCustom == 0 ? 0 : indexCustom + 1;
      tempCustom++;
    }

    return indexCustom;
  }

  String customContactValue(CustomContactField customContact) {
    for (CustomContactField value in item.value.user!.customContactField!) {
      if (customContact.id == value.id) {
        return "${value.value}";
      }
    }
    return '';
  }

  double listHeight(int length,
      {bool? isContact = true,
      List<CustomContactField>? contacts,
      List<CustomFields>? customs}) {
    double kSize = 0;
    if (isContact! == true) {
      for (CustomContactField item in contacts!) {
        ProfileUserConverter().convertProfileType(item.type!) ==
                ProfileType.textarea
            ? kSize = kSize + 180
            : kSize = kSize + 90;
      }
    } else {
      for (CustomFields item in customs!) {
        ProfileUserConverter().convertProfileType(item.type!) ==
                ProfileType.textarea
            ? kSize = kSize + 184
            : kSize = kSize + 92;
      }
    }
    return kSize;
  }

  void editCustomField(String keyName, String value, int index) async {
    try {
      CustomFieldParam customFieldParam =
          CustomFieldParam('custom_fields[$keyName]', value, item.value.id!);
      var result = await _chatRepository.editCustomField(customFieldParam);

      item.value.customFields![index].value = value;

      change(result, status: RxStatus.success());
    } on DioError catch (error) {
      change(error.message, status: RxStatus.error());
      printError(info: 'Error edit custom Field : ${error.message}');
    }
  }

  void editCustomContactField(
      CustomContactField customContactField, String value, int index) async {
    try {
      int? clientId =
          PreferenceUtils().getFromPreferences(StringPreferences.clientId) ?? 0;
      customContactField.value = value;
      CustomContactParam customContactParam = CustomContactParam(
          item.value.user!.id!,
          clientId!,
          jsonEncode(customContactField.toJson()),
          item.value.id!);

      var result =
          await _chatRepository.editCustomContactField(customContactParam);
      bool isSame = false;
      for (CustomContactField value in item.value.customContactField!) {
        if (value.id == customContactField.id) {
          isSame = true;
        }
      }
      if (isSame == false) {
        item.value.user!.customContactField!.add(customContactField);
      }
      change(result, status: RxStatus.success());
    } on DioError catch (error) {
      change(error.message, status: RxStatus.error());
      printError(info: 'Error edit custom contact : ${error.message}');
    }
  }
}
