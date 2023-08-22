import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../widgets/app.snackbar.dart';

class Util {
  static Future<String> loadJsonAsset(String path) async {
    return await rootBundle.loadString(path);
  }

  static Future<Uint8List?> capturePng(GlobalKey globalKey) async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      return pngBytes;
      // print(pngBytes);
    } catch (e) {
      AppSnackBar.error(message: e.toString());
    }
  }

  static String readTestFixture(String name) =>
      File('test/fixtures/$name').readAsStringSync();

  static String readFixture(String name) =>
      File('assets/fixtures/$name').readAsStringSync();

  static bool isUrl(String x) {
    try {
      return Uri.parse(x).isAbsolute;
    } catch (e) {
      return false;
    }
  }

  static String? validateNoEmpty(dynamic input) {
    if (input == null ||
        (input.runtimeType == String && input.trim().isEmpty)) {
      return 'Required Field!';
    }
    return null;
  }

  static Future GetImage(BuildContext context, Function(bool) isLoading,
      Function(String) onUpload) async {
    try {
      File image;
      var imagePicker =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      isLoading(true);
      if (imagePicker != null) {
        image = File(imagePicker.path);
        if (await image.exists()) {
          onUpload(imagePicker.path);
        }
      }
      isLoading(false);
    } catch (e) {
      print('Image picking error: $e');
    }
  }

  static String GetTimeZoneOffset() {
    Duration duration = DateTime.now().timeZoneOffset;
    String toDigits(int n) => n.toString().padLeft(2, "0");
    String twoHour = twoDigits(duration.inHours);
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    if (duration.inMinutes > 0) {
      return "+$twoHour:$twoDigitMinutes";
    }
    return "-$twoHour:$twoDigitMinutes";
  }

  static String twoDigits(int num) {
    return num < 10 ? '0$num' : '$num';
  }

  static DateTime ParseDate(String value) {
    String dateUtc = value
        .substring(
            0,
            (value.lastIndexOf('+') == -1
                    ? value.lastIndexOf('-')
                    : value.lastIndexOf('+')) -
                1)
        .replaceAll("T", " ");
    var time = DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateUtc, true);
    Duration d = ParseTimeZoneOffset(value);
    if (d.inMinutes == 0) {
      return time.toLocal();
    } else {
      if (value.lastIndexOf('+') == -1) {
        time.add(Duration(minutes: time.timeZoneOffset.inMinutes.abs()));
      } else {
        time.subtract(Duration(minutes: time.timeZoneOffset.inMinutes.abs()));
      }
      return time.toLocal();
    }
  }

  static Duration ParseTimeZoneOffset(String val) {
    String t1 = val.substring(
        val.lastIndexOf('+') == -1
            ? val.lastIndexOf('-') + 1
            : val.lastIndexOf('+') + 1,
        val.lastIndexOf(':') - 1);
    String t2 = val.substring(val.lastIndexOf(':') + 1);
    return Duration(minutes: int.parse(t2), hours: int.parse(t2));
  }
}
