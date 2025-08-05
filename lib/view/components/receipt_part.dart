import 'package:fit_life/model/client.dart';
import 'package:fit_life/model/receipt.dart';
import 'package:fit_life/view/components/receipt_item.dart';
import 'package:fit_life/view/constant.dart';
import 'package:fit_life/view/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReceiptPart extends StatelessWidget {
  final ReceiptModel receiptObj;

  final ClientModel client;

  const ReceiptPart(
      {super.key, required this.receiptObj, required this.client});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: AppTheme.primaryColor,
        ),
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.greenAccent,
              size: 80,
            ),
            const SizedBox(height: 10),
            Text(
              "Payment Completed",
              style: kPageHeader.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 12),
            const SizedBox(height: 20),

            /// Table Header
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 120,
                      child: Text("Session",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold))),
                  SizedBox(
                      width: 60,
                      child: Text("Duration",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13))),
                  SizedBox(
                    width: 100,
                    child: Text(
                      "Price(MMK)",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),

            /// Receipt Items
            Expanded(
              child: ListView.builder(
                itemCount: receiptObj.sessions.length,
                itemBuilder: (context, index) {
                  return ReceiptItem(
                    sessionName: receiptObj.sessions[index]['type'],
                    duration:
                        "${Duration(milliseconds: receiptObj.sessions[index]['duration']).inHours}hr ${Duration(milliseconds: receiptObj.sessions[index]['duration']).inMinutes % 60}mins",
                    price: receiptObj.sessions[index]['fees'].toString(),
                  );
                },
              ),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Discount: ${receiptObj.discountRate}",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13)),
                Text(
                  "Extra fees: ${receiptObj.extraFees}",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
              ],
            ),
            SizedBox(height: 30),
            Text("Total: ${receiptObj.totalAmount} MMK",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('MMMM d, y').format(receiptObj.createdDate),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
                Text(
                  "Client: ${client.name}",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
