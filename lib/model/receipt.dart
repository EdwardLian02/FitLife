import 'package:cloud_firestore/cloud_firestore.dart';

class ReceiptModel {
  final String receiptID;
  final String clientName;
  final List<Map<String, dynamic>> sessions;
  final int totalAmount;
  final int discountRate;
  final int extraFees;
  final DateTime createdDate;

  ReceiptModel({
    required this.receiptID,
    required this.clientName,
    required this.sessions,
    required this.totalAmount,
    required this.discountRate,
    required this.extraFees,
    required this.createdDate,
  });

  Map<String, dynamic> toMap() => {
        'receiptID': receiptID,
        'clientName': clientName,
        'sessions': sessions,
        'totalAmount': totalAmount,
        'discountRate': discountRate,
        'extraFees': extraFees,
        'createdDate': createdDate,
      };

  factory ReceiptModel.fromMap(Map<String, dynamic> data) {
    return ReceiptModel(
      receiptID: data["receiptID"],
      clientName: data['clientName'],
      sessions: data['sessions'],
      totalAmount: data["totalAmount"],
      discountRate: data["discountRate"],
      extraFees: data['extraFees'],
      createdDate: data["createdDate"] is Timestamp
          ? (data["createdDate"] as Timestamp).toDate()
          : data["createdDate"],
    );
  }
}
