import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    required this.obscureText,
    required this.keyboardType,
    this.controller,
    this.validator,
    this.onChanged,
    this.maxLines,
    this.focusNode,
  });

  final String hintText;
  final Widget? prefixIcon;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final int? maxLines;
  final bool obscureText;
  final FocusNode? focusNode;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        focusNode: focusNode,
        //onTapOutside: (event) => FocusScope.of(context).unfocus(),
        maxLines: maxLines,
        keyboardType: keyboardType,
        controller: controller,
        validator: validator,
        onChanged: onChanged,
        obscureText: obscureText,
        decoration: InputDecoration(
          // hintText:  hintText,
          label: Text(hintText),
          labelStyle: const TextStyle(
            color: Color.fromARGB(255, 61, 103, 109),
          ),

          alignLabelWithHint: true,

          //floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 61, 103, 109),
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 61, 103, 109),
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 61, 103, 109),
              )),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ));
  }
}
