import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';

class IndividualReceiptScreen extends StatelessWidget {
  final Map<String, dynamic> receiptData;
  const IndividualReceiptScreen({super.key, required this.receiptData});

  String formatDuration(int milliseconds) {
    Duration duration = Duration(milliseconds: milliseconds);
    int minutes = duration.inMinutes;
    return "$minutes min";
  }

  @override
  Widget build(BuildContext context) {
    DateTime datetime = (receiptData["createdDate"] as Timestamp).toDate();
    String formattedDate =
        DateFormat('EEEE, d MMM yyyy • HH:mm').format(datetime);

    return Scaffold(
      appBar: AppBar(
        title: Text("Receipt Details"),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(receiptData["clientName"],
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(LucideIcons.calendar,
                            size: 18, color: Colors.grey[600]),
                        SizedBox(width: 6),
                        Text(formattedDate,
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[600])),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Text("Sessions",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            ...receiptData['sessions'].map<Widget>((session) {
              return Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  leading: Icon(LucideIcons.activity, color: Colors.blue),
                  title: Text("Type: ${session["type"]}",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  subtitle: Text(
                      "Duration: ${formatDuration(session["duration"])}",
                      style: TextStyle(color: Colors.grey[700])),
                  trailing: Text(
                    "${session["fees"]} MMK",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                ),
              );
            }).toList(),
            SizedBox(height: 16),
            Divider(),
            SizedBox(height: 8),
            _buildAmountRow("Discount", "${receiptData["discountRate"]} %"),
            _buildAmountRow("Extra Fees", "${receiptData["extraFees"]} MMK"),
            SizedBox(height: 12),
            _buildTotalAmount("${receiptData["totalAmount"]} MMK"),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16, color: Colors.grey[700])),
          Text(value,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildTotalAmount(String amount) {
    return Card(
      color: Colors.green[100],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Total Amount",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(amount,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[800])),
          ],
        ),
      ),
    );
  }
}
