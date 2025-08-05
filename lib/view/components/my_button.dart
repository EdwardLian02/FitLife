import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String name;
  final void Function()? onPressed;

  const MyButton({super.key, required this.name, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 264,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF7D59EE), // Primary purple color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Rounded corners
          ),
        ),
        onPressed: onPressed,
        child: Text(
          name,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Colors.white, // White text color
          ),
        ),
      ),
    );
  }
}
