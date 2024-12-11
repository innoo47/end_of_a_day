// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  final int maxLength;
  final int? maxLines;
  final double fontSize;
  final String labelText;
  final String? initialValue;
  final FormFieldSetter<String> onSaved; // 폼 저장시
  final FormFieldValidator<String> validator; // 폼 검증시

  const CustomTextField({
    super.key,
    required this.maxLength,
    this.maxLines,
    required this.fontSize,
    required this.labelText,
    this.initialValue,
    required this.onSaved,
    required this.validator,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: widget.onSaved,
      validator: widget.validator,
      initialValue: widget.initialValue,
      cursorColor: Colors.grey,
      maxLength: widget.maxLength,
      maxLines: widget.maxLines,
      keyboardType: TextInputType.text,
      style: TextStyle(
        fontSize: widget.fontSize.sp,
        color: Colors.black,
        fontFamily: 'MaruBuriRegular',
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        labelText: widget.labelText,
        labelStyle: TextStyle(
          fontSize: widget.fontSize.sp,
          color: Colors.grey,
          fontWeight: FontWeight.w100,
          fontFamily: 'MaruBuriRegular',
        ),
        floatingLabelStyle: TextStyle(
          fontSize: widget.fontSize.sp,
          color: Colors.grey,
          fontWeight: FontWeight.w100,
          fontFamily: 'MaruBuriRegular',
        ),
      ),
    );
  }
}
