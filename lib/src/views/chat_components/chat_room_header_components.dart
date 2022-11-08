import 'package:core/core.dart';

import '../../../main_lib.dart';

class ChatRoomHeaderComponents extends GetView<ChatRoomController> {
  const ChatRoomHeaderComponents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListTile(
        onTap: () => controller.profileOnTapped(),
        horizontalTitleGap: 8,
        contentPadding: EdgeInsets.zero,
        title: Text(
          'Sociomile x Paruhwaktu',
          style: subtitle1().copyWith(fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
        // leading: PlaceholderWidget(
        //     imgAssets: controller.ticketData.value.user != null
        //         ? controller.ticketData.value.user!.avatar
        //         : Get.arguments['user']['avatar'],
        //     imgPlaceholder: AssetsCollection.ic_avatar),
        // title: Text(
        //     controller.ticketData.value.user != null
        //         ? controller.ticketData.value.user!.name
        //         : Get.arguments['user']['real_name'],
        //     overflow: TextOverflow.ellipsis,
        //     style: subtitle1().copyWith(fontWeight: FontWeight.w500)),
        // subtitle: Padding(
        //     padding: const EdgeInsets.only(top: 5.0),
        //     child: Row(children: [
        //       Image.asset(
        //           '${controller.ticketData.value.service ?? Get.arguments['source']}'
        //               .chatSourceConverter(),
        //           height: 15.w,
        //           fit: BoxFit.fitHeight),
        //       const SizedBox(width: 8),
        //       Container(
        //           padding: const EdgeInsets.all(3),
        //           decoration: BoxDecoration(
        //               color: Colors.white,
        //               border: Border.all(color: const Color(0xFF1B1B1B)),
        //               borderRadius:
        //                   const BorderRadius.all(Radius.circular(2.0))),
        //           child: Text(
        //               (controller.ticketData.value.type ??
        //                       Get.arguments['type'])
        //                   .toString()
        //                   .capitalizeFirst!,
        //               style:
        //                   body4().copyWith(color: const Color(0xFF1B1B1B)))),
        //       const SizedBox(width: 8),
        //       Text(
        //           '#${controller.ticketData.value.no ?? Get.arguments['no']}',
        //           style: body3().copyWith(color: const Color(0xFF1B1B1B)))
        //     ]))
      );
    });
  }
}
