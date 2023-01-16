import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:heic_to_jpg/heic_to_jpg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:mvvm_template/core/others/logger_customization/custom_logger.dart';
import 'package:path/path.dart' as p;

class FilePickerService {
  File? selectedImage;
  final _imagePicker = ImagePicker();
  final Logger log = CustomLogger(className: 'FilePickerService');

  Future<File?> pickImage() async {
    return await pickImageWithoutCompression();
  }

  ///picks an image from gallery and returns a compressed [File]
  Future<File?> pickImageWithCompression({int imageQuality = 50}) async {
    File? selectedImage;
    final image = await _imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: imageQuality);
    if (image != null) selectedImage = File(image.path);

    log.d('@pickImageWithCompression: Image Size: ${await image?.length()}');
    return selectedImage;
  }

  ///picks an image from gallery and returns a [File] without compression
  Future<File?> pickImageWithoutCompression() async {
    File? selectedImage;
    final filePicker = FilePicker.platform;
    FilePickerResult? result = await filePicker.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      selectedImage = File(result.paths.first!);
      final extension = p.extension(selectedImage.path);
      debugPrint('@FilePickerService.pickImage ==> Extension: $extension');
      if (extension == '.heic') {
        String? jpegPath = await HeicToJpg.convert(selectedImage.path);
        if (jpegPath != null) selectedImage = File(jpegPath);
      }
      // final newPath = '$dir/test.jpg';
      // final compressedImage = await _compressImageFile(selectedImage, newPath);
      // if (compressedImage != null) {
      //   selectedImage = compressedImage;
      // }
    }
    return selectedImage;
  }

  // Future<File?> _compressImageFile(File file, String targetPath) async {
  //   debugPrint(
  //       '@compressImageFile => Size before compression: ${await file.length()}');
  //   var result = await FlutterImageCompress.compressAndGetFile(
  //     file.absolute.path,
  //     targetPath,
  //     quality: 70,
  //   );

  //   if (result != null) {
  //     print('File compressed successfully');
  //   } else {
  //     print('Compressed file path is null');
  //   }

  //   debugPrint(
  //       '@compressImageFile => Size after compression: ${await result?.length()}');
  //   return result;
  // }
}
