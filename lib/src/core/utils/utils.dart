import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Util {
  static Future<String> loadJsonAsset(String path) async {
    return await rootBundle.loadString(path);
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
  }
}
