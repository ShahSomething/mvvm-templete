import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final bool? obscure;
  final String? errorText;
  final String? hintText;
  final bool? enabled;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final double? fontSize;
  final String? label;
  final void Function(String?)? onSaved;
  final VoidCallback? onTap;
  final bool disableBorder;
  final void Function(String?)? onChanged;
  const CustomTextField(
      {Key? key,
      this.controller,
      this.onTap,
      this.disableBorder = false,
      this.label,
      this.obscure = false,
      this.enabled = true,
      this.validator,
      this.errorText,
      this.fontSize = 15.0,
      this.hintText,
      this.onSaved,
      this.suffixIcon,
      @required this.prefixIcon,
      this.onChanged})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      onTap: onTap,
      onSaved: onSaved,
      enabled: enabled,
      controller: controller,
      obscureText: obscure!,
      validator: validator ??
          (value) {
            if (value != null) {
              return errorText;
            } else {
              return null;
            }
          },
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        prefixIconConstraints: const BoxConstraints(),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: prefixIcon!,
        ),
        suffixIcon: Padding(
            padding: const EdgeInsets.only(), child: suffixIcon ?? Container()),
        suffixIconConstraints:
            const BoxConstraints(maxHeight: 40, maxWidth: 50),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.0),
          borderSide: const BorderSide(width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: disableBorder
                  ? Colors.transparent
                  : const Color(0xFF686868).withOpacity(0.4)),
          borderRadius: BorderRadius.circular(14.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: disableBorder
                  ? Colors.transparent
                  : const Color(0xFF686868).withOpacity(0.4)),
          borderRadius: BorderRadius.circular(14.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color: disableBorder
                  ? Colors.transparent
                  : const Color(0xFF686868).withOpacity(0.4)),
          borderRadius: BorderRadius.circular(14.0),
        ),
        contentPadding: const EdgeInsets.only(left: 21.0),
        hintText: hintText,
      ),
    );
  }
}
