// import 'dart:io';
// import 'package:core/core.dart';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:permission_handler/permission_handler.dart';

// class ExportUtils {
//   final AnalyticsService _analyticsService = AnalyticsService();

//   Future<Uint8List?> convertWidgetToImg(GlobalKey key) async {
//     RenderRepaintBoundary? boundary =
//         key.currentContext!.findRenderObject() as RenderRepaintBoundary?;
//     ui.Image image = await boundary!.toImage(pixelRatio: 3.0);

//     ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//     Uint8List pngBytes = byteData!.buffer.asUint8List(0);
//     printInfo(info: 'pngBytes: $pngBytes');
//     return pngBytes;
//   }

//   Future<Uint8List?> sharePng(GlobalKey key,
//       {String? title, String? description}) async {
//     try {
//       convertWidgetToImg(key).then((pngBytes) async {
//         final RenderBox box = Get.context!.findRenderObject() as RenderBox;
//         if (Platform.isAndroid) {
//           final directory = (await getExternalStorageDirectory())!.path;
//           File imgFile = new File('$directory/screenshot.png');
//           imgFile.writeAsBytes(pngBytes!);

//           Share.shareFiles([imgFile.path],
//               subject: 'Share ScreenShot',
//               text: '$title \n$description',
//               sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
//         } else {
//           String path = await _writeByteToImgFileIos(pngBytes!);

//           Share.shareFiles([path],
//               subject: 'Share ScreenShot',
//               text: '$title \n$description',
//               sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
//         }

//         await _analyticsService.logShareWidget(chart: title);

//         return pngBytes;
//       });
//     } catch (e) {
//       printError(info: 'Error_sharePng : $e');
//     }
//   }

//   Future<String> _writeByteToImgFileIos(Uint8List byteData) async {
//     final directory = await getTemporaryDirectory();
//     File imgFile = new File(
//         "${directory.path}/screenshot/${DateTime.now().millisecondsSinceEpoch}.png");
//     imgFile.createSync(recursive: true);
//     imgFile.writeAsBytesSync(byteData);
//     return imgFile.path;
//   }

//   Future<File?> createPdf(List<Uint8List?> image) async {
//     Directory? directory;
//     try {
//       printInfo(info: 'length: ${image.length}');

//       List<pw.Widget> listImage = image
//           .map((e) => pw.AspectRatio(
//               aspectRatio: 1, child: pw.Image(pw.MemoryImage(e!))))
//           .toList();
//       var pdf = new pw.Document();
//       pdf.addPage(pw.MultiPage(
//           pageFormat: PdfPageFormat.a4,
//           crossAxisAlignment: pw.CrossAxisAlignment.center,
//           build: (pw.Context context) {
//             return listImage;
//           }));

//       if (Platform.isAndroid) {
//         if (await _requestPermission(Permission.storage)) {
//           directory = await getExternalStorageDirectory();

//           String newPath = "";
//           printInfo(info: "$directory");
//           List<String> paths = directory!.path.split("/");
//           for (int x = 1; x < paths.length; x++) {
//             String folder = paths[x];
//             if (folder != "Android") {
//               newPath += "/" + folder;
//             } else {
//               break;
//             }
//           }
//           newPath = newPath + "/Download";

//           directory = Directory(newPath);
//         }
//       } else {
//         LogUtil().loggingTest('IOS');
//         directory = await getApplicationDocumentsDirectory();
//       }
//       LogUtil().loggingTest('path: $directory');
//       File saveFile = File(directory!.path + "/ripple10.pdf");
//       if (!await directory.exists()) {
//         await directory.create(recursive: true);
//       }
//       if (await directory.exists()) {
//         LogUtil().loggingTest('length: ${image.length}');

//         return await saveFile.writeAsBytes(await pdf.save());
//       }
//     } catch (e) {
//       printInfo(info: 'failed making pdf $e');
//     }
//   }

//   Future<bool> _requestPermission(Permission? permission) async {
//     if (await permission!.isGranted) {
//       return true;
//     } else {
//       var result = await permission.request();
//       if (result == PermissionStatus.granted) {
//         return true;
//       }
//     }
//     return false;
//   }
// }
