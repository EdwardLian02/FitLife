import 'package:flutter/material.dart';

class OtherInputField extends StatefulWidget {
  final Widget? child;
  final bool Function() colorValidation;
  const OtherInputField({
    super.key,
    this.child,
    required this.colorValidation,
  });

  @override
  State<OtherInputField> createState() => _OtherInputFieldState();
}

class _OtherInputFieldState extends State<OtherInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 42,
      padding: EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        border: Border.all(
          style: BorderStyle.solid,
          color: widget.colorValidation()
              ? Color(0xFFB0AEAE)
              : Color.fromARGB(255, 244, 54, 54),
        ),
        borderRadius: BorderRadius.circular(7),
      ),
      child: widget.child,
    );
  }
}
