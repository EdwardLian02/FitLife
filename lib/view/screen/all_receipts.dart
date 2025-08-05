import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_life/view/screen/individual_receipt_screen.dart';
import 'package:fit_life/viewModel/receipt_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AllReceipts extends StatelessWidget {
  const AllReceipts({super.key}); // Replace with actual receipt data

  @override
  Widget build(BuildContext context) {
    final receiptViewModel = Provider.of<ReceiptViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Receipts"),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: receiptViewModel.fetchReceipt(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final receiptList = snapshot.data!.docs;

              return ListView.builder(
                itemCount: receiptList.length,
                itemBuilder: (context, index) {
                  final receipt =
                      receiptList[index].data() as Map<String, dynamic>;
                  print(receipt);
                  Timestamp timestamp =
                      receipt["createdDate"]; // Firebase Timestamp
                  DateTime dateTime = timestamp.toDate(); // Convert to DateTime
                  String formattedDate =
                      DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    elevation: 3,
                    child: ListTile(
                      title: Text(receipt["clientName"],
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(
                        formattedDate.split('.')[0], // Formats DateTime
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      trailing: Text(
                        "${receipt["totalAmount"].toStringAsFixed(2)} MMK", // Formats amount
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => IndividualReceiptScreen(
                                      receiptData: receipt,
                                    )));
                      },
                    ),
                  );
                },
              );
            } else {
              return Text("There are no receipt");
            }
          }),
    );
  }
}
