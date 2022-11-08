import 'package:core/core.dart';
import '../../main_lib.dart';

class PictureDetailPage extends StatelessWidget {
  const PictureDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Image.asset(AssetsCollection.bg_lighter,
          fit: BoxFit.fill, width: Get.size.width, height: Get.size.height),
      Column(children: [
        Padding(
            padding: const EdgeInsets.only(top: 24, left: 8),
            child: Column(children: [
              Row(children: [
                IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.arrow_back_ios)),
                Expanded(
                    child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: PlaceholderWidget(
                            imgAssets: Get.arguments['avatar']),
                        title: Text(Get.arguments['name'], style: subtitle1()),
                        subtitle: Text(Get.arguments['date'], style: body4()),
                        trailing: _copyButton(Get.arguments['url'])))
              ]),
              const Divider(
                  color: ColorsCollection.cDivider, height: 1, thickness: 1.2)
            ])),
        Expanded(
            child: Center(
                child: FadeInImage(
                    image: NetworkImage(Get.arguments['url'] ??
                        AssetsCollection.img_placeholder_url),
                    placeholder:
                        const AssetImage(AssetsCollection.img_placeholder),
                    placeholderErrorBuilder: (_, error, stackTrace) =>
                        const PlaceholderWidget().imgErrorWidget(),
                    imageErrorBuilder: (context, error, stackTrace) =>
                        const PlaceholderWidget().imgErrorWidget(),
                    fit: BoxFit.cover)))
      ])
    ]));
  }

  Widget _copyButton(String? data) {
    return Builder(builder: (context) {
      return IconButton(
          icon: const Icon(Icons.content_copy, color: Colors.white),
          onPressed: () {
            const snackbar = SnackBar(content: Text('Berhasil Tersalin'));
            Clipboard.setData(ClipboardData(text: data));
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
          });
    });
  }
}
