import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rushikesh_engg/theme.dart';

class CustomFormField extends StatelessWidget {
  final String hintText;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool? isReadOnly;
  final int? maxLineCount;
  CustomFormField({
    Key? key,
    required this.hintText,
    this.inputFormatters,
    this.validator,
    required this.controller,
    this.isReadOnly = false,
    this.maxLineCount = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: textWhiteGrey,
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: TextFormField(
        inputFormatters: inputFormatters,
        validator: validator,
        controller: controller,
        readOnly: isReadOnly!,
        maxLines: maxLineCount,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: heading6.copyWith(color: textGrey),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
