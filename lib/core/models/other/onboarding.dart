import 'package:flutter/material.dart';

class Onboarding {
  late String? imgUrl;
  late String? title;

  Onboarding(this.imgUrl, this.title);

  Onboarding.fromJson(json) {
    debugPrint('$json');
    title = json['title'];
    imgUrl = json['image_url'];
  }
}
