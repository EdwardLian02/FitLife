import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_life/model/client.dart';
import 'package:fit_life/service/database_service.dart';
import 'package:flutter/material.dart';

class ClientViewModel extends ChangeNotifier {
  final _dbService = DatabaseService();
  late ClientModel currentClient;

  int clientCount = 0;
  void updateClientCount(int count) {
    clientCount = count;
    notifyListeners();
  }

  void getClientCount() async {
    int count = await _dbService.getDocumentCount('clients');

    updateClientCount(count);
  }

  //create client
  Future<void> createClient(ClientModel client) async {
    client.cid = _dbService.generateId("client");

    await _dbService.addClient(client);
    getClientCount();
  }

  //interacting with firestore service to fetch client
  Stream<QuerySnapshot> fetchClient() {
    return _dbService.fetchClients();
  }

  //update client
  Future<void> updateClient(ClientModel client) async {
    await _dbService.updateClient(client);
    currentClient = client;
    notifyListeners();
  }

  //delete client
  Future<void> deleteClient(String clientId) async {
    await _dbService.deleteClient(clientId);
    getClientCount();
  }
}
