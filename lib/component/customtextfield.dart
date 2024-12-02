import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final int maxLength;
  final int? maxLines;
  final double fontSize;
  final String labelText;
  final FormFieldSetter<String> onSaved; // 폼 저장시
  final FormFieldValidator<String> validator; // 폼 검증시

  const CustomTextField({
    super.key,
    required this.maxLength,
    this.maxLines,
    required this.fontSize,
    required this.labelText,
    required this.onSaved,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      validator: validator,
      cursorColor: Colors.grey,
      maxLength: maxLength,
      maxLines: maxLines,
      keyboardType: TextInputType.text,
      style: TextStyle(
        fontSize: fontSize.sp,
        color: Colors.black,
        fontFamily: 'MaruBuriRegular',
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        labelText: labelText,
        labelStyle: TextStyle(
          fontSize: fontSize.sp,
          color: Colors.grey,
          fontWeight: FontWeight.w100,
          fontFamily: 'MaruBuriRegular',
        ),
        floatingLabelStyle: TextStyle(
          fontSize: fontSize.sp,
          color: Colors.grey,
          fontWeight: FontWeight.w100,
          fontFamily: 'MaruBuriRegular',
        ),
      ),
    );
  }
}
