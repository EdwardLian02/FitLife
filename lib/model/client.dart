import 'package:cloud_firestore/cloud_firestore.dart';

class ClientModel {
  String cid;
  final String name;
  final String email;
  final String phone;
  final DateTime createdDate;

  ClientModel({
    required this.cid,
    required this.name,
    required this.email,
    required this.phone,
    required this.createdDate,
  });

  Map<String, dynamic> toMap() => {
        'cid': cid,
        'name': name,
        'email': email,
        'phone': phone,
        'createdDate': createdDate,
      };

  factory ClientModel.fromMap(Map<String, dynamic> data) {
    return ClientModel(
      cid: data['cid'],
      name: data['name'],
      email: data['email'],
      phone: data['phone'],
      createdDate: data['createdDate'] is Timestamp
          ? (data['createdDate'] as Timestamp).toDate()
          : data['createdDate'],
    );
  }
}
