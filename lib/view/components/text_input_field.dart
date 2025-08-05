import 'package:fit_life/view/constant.dart';
import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final Widget? child;
  final TextEditingController textController;
  const TextInputField({
    super.key,
    this.child,
    required this.textController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 42,
      padding: EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.centerLeft,
      child: child ??
          TextField(
            controller: textController,
            decoration: inputFieldDecoration,
          ),
    );
  }
}
