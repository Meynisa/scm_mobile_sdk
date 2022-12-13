import 'package:core/core.dart';
import '../../../main_lib.dart';

class ChatRoomHeaderComponents extends GetView<ChatRoomController> {
  const ChatRoomHeaderComponents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListTile(
          horizontalTitleGap: 8,
          contentPadding: EdgeInsets.zero,
          title: Text('Sociomile x Paruhwaktu',
              style: subtitle1().copyWith(fontWeight: FontWeight.w500),
              textAlign: TextAlign.center));
    });
  }
}
