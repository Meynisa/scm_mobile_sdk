import 'package:core/core.dart';
import '../../main_lib.dart';

class TagViewModel extends SearchDelegate<ActivityCode?> {
  final CategoryController categoryController = Get.find<CategoryController>();
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(icon: const Icon(Icons.clear), onPressed: () => query = "")
    ];
  }

  @override
  String get searchFieldLabel => 'Search';

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: const BackButtonIcon(), onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    return categoryController.obx(
        (state) =>
            (state as List<ActivityCode>).isEmpty || (state)[0].id == null
                ? AlertDialogCustom().emptyWidget()
                : ListView.builder(
                    itemCount: state.length,
                    itemBuilder: (_, index) => _listItem(state[index])),
        onLoading: AlertDialogCustom().loadingProgressIndicator(),
        onError: (error) => AlertDialogCustom().onError(
            onPressed: () => categoryController.tagAutoComplete(query)),
        onEmpty: AlertDialogCustom().emptyWidget());
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    categoryController.tagAutoComplete(query);
    return categoryController.obx(
        (state) =>
            (state as List<ActivityCode>).isEmpty || (state)[0].id == null
                ? AlertDialogCustom().emptyWidget()
                : ListView.builder(
                    itemCount: state.length,
                    itemBuilder: (_, index) => _listItem(state[index])),
        onLoading: AlertDialogCustom().loadingProgressIndicator(),
        onError: (error) => AlertDialogCustom().onError(
            onPressed: () => categoryController.tagAutoComplete(query)),
        onEmpty: AlertDialogCustom().emptyWidget());
  }

  Widget _listItem(ActivityCode data) {
    return ListTile(
        title: Text('${data.code} ${data.description}'),
        onTap: () => close(Get.context!, data));
  }
}
