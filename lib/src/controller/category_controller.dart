import 'package:core/core.dart';
import '../../../main_lib.dart';

class CategoryController extends GetxController with StateMixin {
  final ChatRepository _chatRepository = ChatRepositoryImpl();

  RxList<ActivityCode> pickedUpTag = RxList<ActivityCode>();
  RxList<ActivityCode> pickedUpCategories = RxList<ActivityCode>();
  RxList<List<ActivityCode>> listCategories = RxList<List<ActivityCode>>();
  List<ActivityCode?> listDropdownValue = [];
  RxBool isLoading = false.obs;
  RxBool isSavedCategory = false.obs;
  MeData? _meData;
  CategoryType categoryType = CategoryType.category;
  int _projectId = 0;
  RxString roomId = ''.obs;
  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    _projectId =
        PreferenceUtils().getFromPreferences(StringPreferences.projectId) ?? 0;
    _meData = MeData.fromJson(
        PreferenceUtils().getFromPreferences(StringPreferences.meSetting) ??
            MeData().toJson());
    categoryType = _meData!.activityCode == 'tag'
        ? CategoryType.tag
        : CategoryType.category;
    super.onInit();
  }

  void fetchMultiCategories(
      {bool isParent = true, String parentId = '', int? index}) async {
    change(null, status: RxStatus.loading());
    MultiCategoryParam multiCategoryParam =
        MultiCategoryParam(_projectId, parentId, isParent);
    isLoading.value = true;
    try {
      List<ActivityCode> result =
          await _chatRepository.fetchMultiCategories(multiCategoryParam);
      if (result.isNotEmpty) {
        if (index != null) {
          if (index + 1 == listDropdownValue.length) {
            listDropdownValue.add(null);
            listCategories.add(result);
          } else {
            listDropdownValue.removeRange(index + 1, listDropdownValue.length);
            listCategories.removeRange(index + 1, listCategories.length);
            listDropdownValue.add(null);
            listCategories.add(result);
          }
        } else {
          listCategories.add(result);
          listDropdownValue.add(null);
        }
        isSavedCategory.value = false;
      } else {
        if (index != null && index + 1 < listDropdownValue.length) {
          listDropdownValue.removeRange(index + 1, listDropdownValue.length);
          listCategories.removeRange(index + 1, listCategories.length);
        }
        isSavedCategory.value = true;
      }

      isLoading.value = false;
    } on DioError catch (error) {
      printError(info: 'Error fetching multi categories : ${error.message}');
      isLoading.value = false;
    }
  }

  void tagAutoComplete(String keyword) async {
    change(null, status: RxStatus.loading());
    TagParam tagParam = TagParam(_projectId, 50, keyword);
    try {
      List<ActivityCode> result =
          await _chatRepository.fetchTagAutoComplete(tagParam);
      change(result, status: RxStatus.success());
    } on DioError catch (error) {
      printError(info: 'Error fetching tag auto complete : ${error.message}');
      change(error.message, status: RxStatus.error());
    }
  }

  void submitCategory() async {
    isLoading.value = true;
    Map<String, dynamic> data = <String, dynamic>{};

    if (categoryType == CategoryType.tag) {
      for (int i = 0; i < pickedUpTag.length; i++) {
        data['id[$i]'] = pickedUpTag[i].id;
      }
    } else {
      String tempId = '';
      int tempListArray = 1;
      int tempN = 0;

      for (int i = 0; i < pickedUpCategories.length; i++) {
        if (i == 0) {
          tempId = pickedUpCategories[i].id!;
          data['id[$tempListArray][$tempN]'] = tempId;
          tempN++;
        } else {
          if (tempId == pickedUpCategories[i].parent) {
            data['id[$tempListArray][$tempN]'] = pickedUpCategories[i].id;
            tempId = pickedUpCategories[i].id!;
            tempN++;
          } else {
            tempN = 0;
            tempListArray++;
            tempId = pickedUpCategories[i].id!;
            data['id[$tempListArray][$tempN]'] = pickedUpCategories[i].id;
            tempN++;
          }
        }
      }
    }
    data['project'] = _projectId;
    data['ticket'] = roomId.value;

    try {
      var result = await _chatRepository.submitCategory(data, categoryType);
      change(result, status: RxStatus.success());
      isLoading.value = false;
      Get.back();
    } on DioError catch (error) {
      printError(info: 'Error fetching tag auto complete : ${error.message}');
      isLoading.value = false;
      Get.snackbar(DictionaryUtil.failed.tr, error.message,
          backgroundColor: ColorsCollection.cBlue,
          colorText: Colors.white,
          animationDuration: const Duration(milliseconds: 400));
    }
  }

  void addCategoryPageBtn() async {
    try {
      categoryType == CategoryType.category
          ? showDialog(
              context: Get.context!,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    content: SizedBox(
                        height: 2 * (Get.size.height / 3),
                        child: const CategoryViewModel()));
              }).then((value) => printInfo(info: 'INFO: $value'))
          : await showSearch(context: Get.context!, delegate: TagViewModel())
              .then((value) {
              printInfo(info: 'Value: $value');
              if (!pickedUpTag.contains(value)) {
                pickedUpTag.add(value!);
                pickedUpCategories.add(value);
              }
            });
    } catch (e) {
      printError(info: 'ERROR: $e');
    }
  }

  void dropDownOnChanged(ActivityCode newValue, int index) {
    listDropdownValue[index] = newValue;
    fetchMultiCategories(isParent: false, parentId: newValue.id!, index: index);
  }

  void backOnTapped() {
    isSavedCategory.value = false;
    isLoading.value = false;
    Get.back();
  }

  void closeCategoryPageBtn() {
    if (categoryType == CategoryType.category) {
      if (pickedUpCategories.isNotEmpty) {
        for (int i = 0; i < pickedUpTag.value.length; i++) {
          for (int j = 0; j < pickedUpCategories.value.length; j++) {
            if (pickedUpTag.value[i].id == pickedUpCategories.value[j].id) {
              pickedUpTag.removeAt(i);
            }
          }
        }
        pickedUpCategories.clear();
      }
      List<ActivityCode> initCategories = listCategories.value[0];
      listCategories.clear();
      listCategories.add(initCategories);
      listDropdownValue.clear();
      listDropdownValue.add(null);
    } else {
      if (pickedUpCategories.isNotEmpty) {
        for (int i = 0; i < pickedUpTag.value.length; i++) {
          for (int j = 0; j < pickedUpCategories.value.length; j++) {
            if (pickedUpTag.value[i].id == pickedUpCategories.value[j].id) {
              pickedUpTag.removeAt(i);
            }
          }
        }
        pickedUpCategories.clear();
      }
    }

    Get.back();
  }

  void addCategoryBtn() {
    List<ActivityCode?> list = listDropdownValue;

    if (pickedUpTag.isNotEmpty) {
      for (int i = 0; i < pickedUpTag.length; i++) {
        if (!pickedUpTag.value.contains(list.last)) {
          list.map((e) => pickedUpCategories.add(e!)).toList();
          pickedUpTag.add(list.last!);
        }
      }
    } else {
      list.map((e) => pickedUpCategories.add(e!)).toList();
      pickedUpTag.add(list.last!);
    }
    backOnTapped();
  }
}
