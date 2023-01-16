import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvvm_template/ui/custom_widgets/single_radio_button.dart';

class GenderRadioGroup extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final model;

  const GenderRadioGroup(this.model, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "gender".tr,
          // style: textStyleWithHacenFont.copyWith(
          //     fontSize: ScreenUtil().setSp(12), color: Colors.white),
        ),
        const SizedBox(width: 40),
        // Radio(
        //   value: 0,
        //   activeColor: primaryColor,
        //   groupValue:
        //       model.selectedGenderIndex,
        //   onChanged: (val) {
        //     model.updateIndex(val);
        //   },
        // ),
        CustomSingleRadioButton(
          isSelected: model.selectedGenderIndex == 0,
          onPressed: () {
            model.updateIndex(0);
          },
        ),
        Text(
          "male".tr,
          // style: textStyleWithHacenFont.copyWith(
          //     fontSize: ScreenUtil().setSp(12), color: Colors.white),
        ),
        const SizedBox(width: 10),
        // Radio(
        //   value: 1,
        //   activeColor: primaryColor,
        //   groupValue: model.selectedGenderIndex,
        //   onChanged: (val) {
        //     model.updateIndex(val);
        //   },
        // ),
        CustomSingleRadioButton(
          isSelected: model.selectedGenderIndex == 1,
          onPressed: () {
            debugPrint('Update Gender Index to 1');
            model.updateIndex(1);
          },
        ),
        Text(
          "female".tr,
          // style: textStyleWithHacenFont.copyWith(
          //     fontSize: ScreenUtil().setSp(12), color: Colors.white),
        ),
      ],
    );
  }
}
