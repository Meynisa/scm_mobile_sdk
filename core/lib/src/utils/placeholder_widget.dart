import 'package:flutter/material.dart';
import '../../core.dart';

class PlaceholderWidget extends StatelessWidget {
  final String? imgAssets;
  final double? borderRadius;
  final double? size;
  final String imgPlaceholder;
  final BoxFit? fit;

  const PlaceholderWidget(
      {Key? key,
      this.imgAssets,
      this.borderRadius = 100.0,
      this.size = 40,
      this.imgPlaceholder = AssetsCollection.img_placeholder,
      this.fit = BoxFit.cover})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius!),
        child: FadeInImage(
            width: size!.w,
            height: size!.w,
            image:
                NetworkImage(imgAssets ?? AssetsCollection.img_placeholder_url),
            placeholder: AssetImage(imgPlaceholder),
            placeholderErrorBuilder: (_, _error, stackTrace) =>
                imgErrorWidget(),
            imageErrorBuilder: (context, error, stackTrace) => imgErrorWidget(),
            fit: fit));
  }

  Widget imgErrorWidget() {
    return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius!),
        child: Image.asset(imgPlaceholder,
            fit: BoxFit.cover, height: size!.w, width: size!.w));
  }
}
