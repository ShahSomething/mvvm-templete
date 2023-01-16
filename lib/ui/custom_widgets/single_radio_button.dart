import 'package:flutter/material.dart';
import 'package:mvvm_template/core/constants/colors.dart';

class CustomSingleRadioButton extends StatelessWidget {
  final bool isSelected;
  // ignore: prefer_typing_uninitialized_variables
  final onPressed;
  const CustomSingleRadioButton(
      {Key? key, this.isSelected = false, this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 14,
          width: 14,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.white,
          ),
          child: Container(
            height: 10,
            width: 10,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: isSelected ? primaryColor : Colors.transparent),
          ),
        ),
      ),
    );
  }
}
