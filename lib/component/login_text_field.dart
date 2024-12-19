import 'package:flutter/material.dart';

class LoginTextField extends StatefulWidget {
  // final int maxLength;
  // final int? maxLines;
  // final double fontSize;
  final String label;
  // final String? initialValue;
  // final FormFieldSetter<String> onSaved; // 폼 저장시
  // final FormFieldValidator<String> validator; // 폼 검증시

  const LoginTextField({
    super.key,
    // required this.maxLength,
    // this.maxLines,
    // required this.fontSize,
    required this.label,
    // this.initialValue,
    // required this.onSaved,
    // required this.validator,
  });

  @override
  State<LoginTextField> createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        label: Text(widget.label),
      ),
    );
  }
}
