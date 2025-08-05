import 'package:fit_life/view/theme/app_theme.dart';
import 'package:flutter/material.dart';

class FlexibleButton extends StatelessWidget {
  final String name;
  final Color color;
  final void Function()? onTap;
  const FlexibleButton(
      {super.key,
      required this.name,
      this.color = AppTheme.primaryColor,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Colors.white, // White text color
              ),
            ),
          ),
        ),
      ),
    );
  }
}
