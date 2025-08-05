import 'package:flutter/material.dart';

class ReceiptItem extends StatelessWidget {
  final String sessionName;
  final String duration;
  final String price;

  const ReceiptItem({
    super.key,
    required this.sessionName,
    required this.duration,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              width: 120,
              child: Text(sessionName,
                  style: const TextStyle(color: Colors.white))),
          SizedBox(
              width: 60,
              child:
                  Text(duration, style: const TextStyle(color: Colors.white))),
          SizedBox(
              width: 100,
              child: Text(price,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }
}
