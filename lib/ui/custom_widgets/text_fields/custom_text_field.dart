import 'package:control_style/control_style.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_template/core/theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final Widget? prefix;
  final Widget? suffix;
  final BoxConstraints? prefixConstraints;
  final BoxConstraints? suffixConstraints;
  final int? maxLines;

  final bool? obscure;
  final String? errorText;
  final double? borderRadius;
  final bool? enabled;
  final double? fontSize;
  final String? label;
  final int? maxLength;
  final void Function(String?)? onSaved;
  final VoidCallback? onTap;
  final bool disableBorder;
  final void Function(String?)? onChanged;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final Color? fillColor;

  const CustomTextField({
    Key? key,
    this.controller,
    this.hintText,
    this.textInputType,
    this.obscure = false,
    this.enabled = true,
    this.validator,
    this.prefix,
    this.suffix,
    this.prefixConstraints,
    this.suffixConstraints,
    this.borderRadius = 10,
    this.maxLines = 1,
    this.errorText,
    this.fontSize = 14.0,
    this.label,
    this.maxLength,
    this.onSaved,
    this.onTap,
    this.disableBorder = false,
    this.onChanged,
    this.textInputAction,
    this.onFieldSubmitted,
    this.fillColor = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      onTap: onTap,
      onSaved: onSaved,
      cursorColor: AppColors.primaryColor,
      enabled: enabled,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      controller: controller,
      maxLines: maxLines,
      keyboardType: textInputType,
      obscureText: obscure!,
      obscuringCharacter: '●',
      maxLength: maxLength,
      style: Theme.of(context).textTheme.labelMedium,
      validator: validator ??
          (value) {
            if (value != null) {
              return errorText;
            } else {
              return null;
            }
          },
      decoration: InputDecoration(
        // contentPadding: EdgeInsets.only(top: 16, left: 16, bottom: 16),
        labelText: label,
        fillColor: fillColor,
        filled: true,
        counter: const Offstage(),
        prefixIconConstraints: prefixConstraints,
        prefixIcon: prefix != null
            ? Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: prefix!,
              )
            : null,
        suffixIcon: suffix != null
            ? Padding(
                padding: const EdgeInsets.only(),
                child: suffix,
              )
            : null,
        suffixIconConstraints: suffixConstraints,
        focusedBorder: DecoratedInputBorder(
          child: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
            borderSide: const BorderSide(
              color: AppColors.primaryColor,
            ),
          ),
        ),
        enabledBorder: DecoratedInputBorder(
          child: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
            borderSide: const BorderSide(
              color: AppColors.greyColor,
            ),
          ),
        ),
        disabledBorder: DecoratedInputBorder(
          child: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
        ),
        border: DecoratedInputBorder(
          child: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
            borderSide: const BorderSide(
              color: AppColors.errorColor,
            ),
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.labelMedium,
        labelStyle: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }
}
