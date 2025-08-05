import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_life/model/receipt.dart';
import 'package:fit_life/model/session.dart';
import 'package:fit_life/service/database_service.dart';
import 'package:flutter/material.dart';

class ReceiptViewModel extends ChangeNotifier {
  final _dbService = DatabaseService();
  late ReceiptModel receipt;
  Future<ReceiptModel> generateReceipt(
      List<SessionModel> sessionList, discountRate, clientName) async {
    List<Map<String, dynamic>> listOfSessionForReceipt = [];

    for (var session in sessionList) {
      listOfSessionForReceipt.add({
        'type': session.type,
        'duration': session.duration.inMilliseconds,
        'fees': session.fees,
      });
    }

    String receiptID = _dbService.generateId("receipts");

    receipt = ReceiptModel.fromMap({
      'receiptID': receiptID,
      'clientName': clientName,
      'sessions': listOfSessionForReceipt,
      'totalAmount':
          calculateTotalAndExtra(discountRate, sessionList)['totalAmount'],
      'discountRate': discountRate,
      'extraFees':
          calculateTotalAndExtra(discountRate, sessionList)['totalExtraFees'],
      'createdDate': DateTime.now(),
    });

    await _dbService.createReceipt(receipt);

    return receipt;
  }

  //this method will return Map which include total amount and extra fees
  Map<String, dynamic> calculateTotalAndExtra(
      int discount, List<SessionModel> sessionList) {
    int totalAmount = 0;
    int totalExtraFees = 0;

    for (var session in sessionList) {
      totalAmount += session.fees;
      totalAmount += session.extraFee;

      totalExtraFees += session.extraFee;
    }

    if (discount > 0) {
      totalAmount -= (totalAmount * (discount / 100)).toInt();
    }

    return {
      'totalAmount': totalAmount,
      'totalExtraFees': totalExtraFees,
    };
  }

  //fetch receipt
  Stream<QuerySnapshot> fetchReceipt() {
    return _dbService.fetchReceipt();
  }
}
