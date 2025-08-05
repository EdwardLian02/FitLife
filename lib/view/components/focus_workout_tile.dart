import 'package:fit_life/view/constant.dart';
import 'package:fit_life/view/theme/app_theme.dart';
import 'package:flutter/material.dart';

class FocusWorkoutTile extends StatelessWidget {
  final String text;
  const FocusWorkoutTile({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Text(
          text,
          style: kSubTitleText.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
