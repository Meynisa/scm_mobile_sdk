import 'package:core/core.dart';
import '../../../main_lib.dart';

class CustomTabViewModel extends GetView<CustomTabviewController> {
  const CustomTabViewModel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller.itemCount! < 1) return controller.stub ?? Container();

    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
              color: Colors.white,
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Container(
                            decoration: controller.roundedContainer
                                ? BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                        color: ColorsCollection.cDefault,
                                        width: 1))
                                : null,
                            child: TabBar(
                                isScrollable:
                                    controller.itemCount! > 3 ? true : false,
                                controller: controller.tabcontroller,
                                labelColor: controller.activeColor,
                                unselectedLabelColor: controller.inactiveColor,
                                indicatorSize: TabBarIndicatorSize.tab,
                                indicatorColor: ColorsCollection.cPurple,
                                indicatorWeight: 3,
                                indicator: controller.roundedIndicator
                                    ? BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: ColorsCollection.cDefault)
                                    : null,
                                labelStyle: subtitle5(),
                                unselectedLabelStyle: subtitle7(),
                                tabs: List.generate(
                                    controller.itemCount!,
                                    (index) => tabItem(
                                        controller.menuTickets[index].name))))),
                    PopupMenuButton<TicketType>(
                        onSelected: (TicketType value) =>
                            controller.jumpToPosition(value.index),
                        icon: Icon(Icons.more_vert_rounded, size: 24.w),
                        itemBuilder: (BuildContext context) => controller
                            .menuBar!
                            .map((TicketType value) =>
                                PopupMenuItem<TicketType>(
                                    value: value,
                                    child: Text(value.name.capitalizeFirst!,
                                        style: body1())))
                            .toList())
                  ])),
          Expanded(
              child: TabBarView(
                  controller: controller.tabcontroller,
                  children: List.generate(controller.itemCount!,
                      (index) => const ChatContentPage())))
        ]);
  }

  Widget tabItem(String? title) {
    return Tab(text: title?.capitalizeFirst);
  }
}
