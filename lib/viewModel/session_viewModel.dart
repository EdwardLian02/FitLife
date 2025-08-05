import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_life/model/client.dart';
import 'package:fit_life/model/receipt.dart';
import 'package:fit_life/model/session.dart';
import 'package:fit_life/service/database_service.dart';
import 'package:fit_life/view/constant.dart';
import 'package:fit_life/viewModel/receipt_viewModel.dart';
import 'package:flutter/material.dart';

class SessionViewModel extends ChangeNotifier {
  final _dbService = DatabaseService();
  final receiptViewModel = ReceiptViewModel();
  late ClientModel
      chosenClient; // For storing the client that trainer choose before adding new sessions
  late ReceiptModel receiptObj;
  Map<String, dynamic> sessionForDetail =
      {}; //For storing a specific session detail for session screen to improve performance.

  List<SessionModel> chosenSessionList = [];

  Stream<int> getSessionCount() {
    return _dbService.fetchSessionCount();
  }

  //Add session for one
  void addSession(SessionModel session) {
    String sessionId = _dbService.generateId("sessions");
    session.sid = sessionId;

    chosenSessionList.add(session);

    //For keep choosing the same client when the user wanna add more session or return to session screen 1
    chosenClient = session.client;

    notifyListeners();
  }

  Future<void> addSessionListToDB({discount}) async {
    //parse the list to the receiptViewModel just for the display and calculation.
    ReceiptModel receipt = await receiptViewModel.generateReceipt(
        chosenSessionList, discount, chosenClient.name);
    receiptObj = receipt;

    //connect with firebase
    await _dbService.addSession(chosenSessionList);
    notifyListeners();
  }

  Stream<List<SessionModel>> fetchSessions() {
    return _dbService.fetchSessions();
  }

  Stream<List<SessionModel>> fetchSessionByClientID(ClientModel client) {
    return _dbService.fetchSessionsByClient(client);
  }

  void assignSessionDetail(Map<String, dynamic> sessionData) {
    Map<String, dynamic> temp = Map<String, dynamic>.from(sessionData);
    if (temp['focusWorkout'] is String) {
      temp['focusWorkout'] = convertStringToList(temp['focusWorkout']);
    }
    sessionForDetail = temp;
    notifyListeners();
  }

  void saveUpdate(String sessionID, String clientName,
      Map<String, dynamic> sessionDetailDataFromUI) {
    print('in save update');
    print(sessionDetailDataFromUI);
    if (sessionForDetail.isNotEmpty) {
      sessionForDetail.clear();
    }

    sessionForDetail = {
      'sid': sessionID,
      'type': sessionDetailDataFromUI["type"],
      'date': (sessionDetailDataFromUI['date'] is Timestamp)
          ? (sessionDetailDataFromUI['date'] as Timestamp).toDate()
          : sessionDetailDataFromUI['date'],
      'time': sessionDetailDataFromUI['time'],
      'clientName': clientName,
      'duration': sessionDetailDataFromUI['duration'],
      'focusWorkout':
          convertStringToList(sessionDetailDataFromUI['focusWorkout']),
      'progress': sessionDetailDataFromUI['progress'],
      'note': sessionDetailDataFromUI['note'],
    };
    notifyListeners();
  }

  Future<void> updateSession(
      Map<String, dynamic> sessionData, Map<String, dynamic> updateData) async {
    updateData['sid'] = sessionData['sid'];
    updateData['progress'] = sessionData['progress'];
    updateData['clientName'] = sessionData['clientName'];
    assignSessionDetail(updateData);
    print("in update session method");
    print(updateData);

    await _dbService.updateSession(sessionData['sid'], updateData);
  }

  //delete session
  Future<void> deleteSession(sessionID) async {
    await _dbService.deleteSession(sessionID);
  }
}
