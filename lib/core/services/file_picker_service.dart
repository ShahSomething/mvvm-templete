import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:heic_to_jpg/heic_to_jpg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:mvvm_template/core/others/logger_customization/custom_logger.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

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
    }
    return selectedImage;
  }

  /// Downloads a file from the given [url] and returns a [File]
  Future<File> downloadFile(String url, String filename) async {
    var httpClient = HttpClient();
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = "";

    dir = (await getTemporaryDirectory()).path;

    File file = File('$dir/$filename');
    await file.writeAsBytes(bytes, mode: FileMode.write);

    return file;
  }

  // Private method
  static Future<File?> _pickImageAndCrop(
      {required Future<File?> Function(File file)? cropImage}) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return null;

    if (cropImage == null) {
      return File(pickedFile.path);
    } else {
      final file = File(pickedFile.path);
      return cropImage(file);
    }
  }

  /// Picks an image from gallery and returns a [File] after cropping.
  /// [isCircle] is used to crop the image in circle shape.
  /// [height] is the height os the cropping area.
  /// Add the following to AndroidManifest.xml:
  /// <activity
  ///  android:name="com.yalantis.ucrop.UCropActivity"
  ///  android:screenOrientation="portrait"
  ///  android:theme="@style/Theme.AppCompat.Light.NoActionBar"/>
  Future<File?> selectAndCropImage(
      {bool isCircle = true, double height = 1.4}) async {
    File? file = await _pickImageAndCrop(cropImage: (File ss) {
      return _onShowcaseImageCrop(ss, isCircle, height);
    });

    return file;
  }

  // Private method
  Future<File?> _onShowcaseImageCrop(
      File file, bool isCircle, double height) async {
    var croppedImage = await ImageCropper().cropImage(
      sourcePath: file.path,
      cropStyle: isCircle ? CropStyle.circle : CropStyle.rectangle,
      compressQuality: 15,
      //aspectRatio: CropAspectRatio(ratioX: 2, ratioY: isCircle ? 2 : height),
      //aspectRatioPresets: [CropAspectRatioPreset.original],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );

    if (croppedImage != null) {
      return File(croppedImage.path);
    } else {
      return null;
    }
  }
}
