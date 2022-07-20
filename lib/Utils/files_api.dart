import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:plasma/View/Widgets/toast_widget.dart';
import 'package:plasma/View/Widgets/translated_text_widget.dart';
import 'package:share_plus/share_plus.dart';

class FilesApi {
  static Future<Uint8List> _convertToImage(GlobalKey repaintBoundaryKey) async {
    final RenderRepaintBoundary boundary = repaintBoundaryKey.currentContext
        ?.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 3);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List imageBytes = byteData!.buffer.asUint8List();
    return imageBytes;
  }

  static Future<String> _getFilePath(
      GlobalKey repaintBoundaryKey, String fileName) async {
    Directory directory = await getApplicationDocumentsDirectory();
    String directoryPath = directory.path;
    File imageFile = await File('$directoryPath/$fileName.png').create();
    Uint8List bytes = await _convertToImage(repaintBoundaryKey);
    imageFile.writeAsBytesSync(bytes);
    return imageFile.path;
  }

  static Future<void> saveImageToGallery(BuildContext context,
      GlobalKey repaintBoundaryKey, String fileName) async {
    await Permission.storage.request();
    Uint8List imageBytes = await _convertToImage(repaintBoundaryKey);
    String dateTime = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    String fName = 'plasma-qr-data:$fileName/$dateTime';
    final path = await ImageGallerySaver.saveImage(imageBytes, name: fName);
    ToastWidget.showToast(context, msg: '${TranslatedTextWidget.translate('QR Image Saved To Path: ')}${path["filePath"]}');
    // final Color toastColor = Theme.of(context).scaffoldBackgroundColor;
    // final Color toastForeground = Theme.of(context).brightness == Brightness.light? Colors.black:Colors.white;
    // Fluttertoast.cancel();
    // Fluttertoast.showToast(
    //   msg: 'QR Image Saved To Path: ${path["filePath"]}',
    //   backgroundColor: toastColor,
    //   textColor: toastForeground,
    //   gravity: ToastGravity.BOTTOM,
    // );
  }

  static Future<void> shareImage(
      GlobalKey repaintBoundaryKey, String fileName) async {
    String filePath = await _getFilePath(repaintBoundaryKey, fileName);
    List<String> filesList = [filePath];
    await Share.shareFiles(filesList);
  }

  static Future<File?> takePhoto(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile == null) return null;
    return File(pickedFile.path);
  }
}
