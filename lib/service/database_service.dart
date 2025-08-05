import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_life/model/client.dart';
import 'package:fit_life/model/progress.dart';
import 'package:fit_life/model/receipt.dart';
import 'package:fit_life/model/session.dart';
import 'package:fit_life/model/user.dart';
import 'package:fit_life/view/constant.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  // getting a collection count that has been parsed to the function.
  Future<int> getDocumentCount(String collectionPath) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection(collectionPath)
          .where('uid', isEqualTo: auth.currentUser!.uid)
          .get();
      return snapshot.size; // Returns the number of documents
    } catch (e) {
      print("Error getting document count: $e");
      return 0; // Return 0 in case of an error
    }
  }

  //To display the session count
  Stream<int> fetchSessionCount() {
    return _db
        .collection("clients")
        .where("uid", isEqualTo: auth.currentUser!.uid)
        .snapshots()
        .asyncMap((clientSnapshot) async {
      if (clientSnapshot.docs.isEmpty) return 0;

      // Extract client IDs associated with the user
      Set<String> clientIds = clientSnapshot.docs.map((doc) => doc.id).toSet();
      if (clientIds.isEmpty) return 0;

      // Fetch sessions related to the extracted client IDs
      var sessionSnapshot = await _db
          .collection("sessions")
          .where("cid", whereIn: clientIds.toList())
          .get();

      print("End of fetch session count in db");
      return sessionSnapshot.docs.length;
    });
  }

  /*
    To generate random id and match with the document id
    so that it is easier to fetch a specific document with 
    doc id. 
  */
  String generateId(collectionName) {
    return _db.collection(collectionName).doc().id;
  }

  //save user data in firebase
  Future<void> saveUserData(TrainerModel user) async {
    await _db.collection("users").doc(user.uid).set(user.toMap());
  }

  //Fetch user data from firebase
  Future<TrainerModel?> fetchUserData(uid) async {
    DocumentSnapshot documentSnapshot =
        await _db.collection("users").doc(uid).get();

    if (documentSnapshot.exists) {
      return TrainerModel.fromMap(
          documentSnapshot.data() as Map<String, dynamic>);
    }

    return null;
  }

  //Update user data from firebase
  Future<void> updateUserData(TrainerModel user) async {
    await _db.collection("users").doc(user.uid).update(user.toMap());
    print("User data is updated!");
  }

  //Create a new client
  Future<void> addClient(ClientModel client) async {
    await _db.collection("clients").doc(client.cid).set({
      'cid': client.cid,
      'name': client.name,
      'email': client.email,
      'phone': client.phone,
      'createdDate': client.createdDate,
      'uid': auth.currentUser!.uid,
    });

    print("Client is created successfully!");
  }

  //Fetch clients from firebase
  Stream<QuerySnapshot> fetchClients() {
    final clientStream = _db
        .collection("clients")
        .where('uid', isEqualTo: auth.currentUser!.uid)
        .snapshots();

    return clientStream;
  }

  Future<Map<String, ClientModel>> fetchClientsByIds(
      Set<String> clientIds) async {
    if (clientIds.isEmpty) return {};

    var snapshot = await _db
        .collection("clients")
        .where(FieldPath.documentId, whereIn: clientIds.toList())
        .get();
    return {
      for (var doc in snapshot.docs) doc.id: ClientModel.fromMap(doc.data())
    };
  }

  Future<Map<String, ReceiptModel>> fetchReceiptsByIds(
      Set<String> receiptIds) async {
    if (receiptIds.isEmpty) return {};

    var snapshot = await _db
        .collection("receipts")
        .where(FieldPath.documentId, whereIn: receiptIds.toList())
        .get();
    return {
      for (var doc in snapshot.docs) doc.id: ReceiptModel.fromMap(doc.data())
    };
  }

  //delete sesson
  Future<void> deleteSession(sessionID) async {
    await _db.collection('sessions').doc(sessionID).delete();
  }

  //Update clients from firebase
  Future<void> updateClient(ClientModel client) async {
    await _db.collection("clients").doc(client.cid).update({
      'name': client.name,
      'email': client.email,
      'phone': client.phone,
    });
  }

  //Add session list
  Future<void> addSession(List<SessionModel> sessionList) async {
    print("IN db, addsession service");
    for (var session in sessionList) {
      //Convert TimeOfDay format into json format in order to store it in firebase
      Map<String, dynamic> timeJson = {
        "hour": session.time.hour,
        "minute": session.time.minute,
        "period": session.time.period == DayPeriod.am ? "AM" : "PM",
      };

      await _db.collection("sessions").doc(session.sid).set({
        "sid": session.sid,
        "cid": session.client.cid,
        "date": session.date,
        "time": timeJson,
        "type": session.type,
        "duration": session.duration.inMilliseconds,
        "focusWorkout": session.focusWorkout,
        "progress": session.progress,
        "note": session.note,
        "fees": session.fees,
        "extraFee": session.extraFee,
      });
    }
  }

  //delete client
  Future<void> deleteClient(String clientID) async {
    await _db.collection('clients').doc(clientID).delete();
    var sessionQuery = await _db
        .collection('sessions')
        .where('cid', isEqualTo: clientID)
        .get();

    for (var sessionDoc in sessionQuery.docs) {
      await sessionDoc.reference.delete();
    }
  }

  //Update session
  Future<void> updateSession(
      String sessionID, Map<String, dynamic> updateData) async {
    // Create a copy of updateData to avoid modifying the original reference
    final Map<String, dynamic> safeUpdateData =
        Map<String, dynamic>.from(updateData);
    safeUpdateData['time'] = converTimeToMap(safeUpdateData['time']);
    safeUpdateData['duration'] = safeUpdateData['duration'].inMilliseconds;
    await _db.collection("sessions").doc(sessionID).update(safeUpdateData);
  }

  Future<ClientModel> fetchClientByID(String clientID) async {
    DocumentSnapshot doc = await _db.collection("clients").doc(clientID).get();
    return ClientModel.fromMap(doc.data() as Map<String, dynamic>);
  }

  //delete session

  //fetch session
  Stream<List<SessionModel>> fetchSessions() {
    print("I am in db fetch session method");
    return _db
        .collection("clients")
        .where("uid", isEqualTo: auth.currentUser!.uid)
        .snapshots()
        .asyncMap((clientSnapshot) async {
      if (clientSnapshot.docs.isEmpty) return [];

      // Extract client IDs associated with the user
      Set<String> clientIds = clientSnapshot.docs.map((doc) => doc.id).toSet();
      if (clientIds.isEmpty) return [];

      // Fetch sessions related to the extracted client IDs
      var sessionSnapshot = await _db
          .collection("sessions")
          .where("cid", whereIn: clientIds.toList())
          .get();
      if (sessionSnapshot.docs.isEmpty) return [];

      List<SessionModel> sessions = [];

      Set<String> receiptIds = {};

      // Extract receipt IDs
      for (var doc in sessionSnapshot.docs) {
        var data = doc.data();
        if (data["rid"] != null) receiptIds.add(data["rid"]);
      }

      // Fetch clients and receipts in bulk
      Map<String, ClientModel> clients = await fetchClientsByIds(clientIds);

      // Map session data with fetched clients & receipts
      for (var doc in sessionSnapshot.docs) {
        var data = doc.data();

        sessions.add(SessionModel(
          sid: data["sid"],
          client: clients[data["cid"]]!,
          date: (data["date"] as Timestamp).toDate(),
          time: convertMapToTime(data['time']),
          type: data["type"],
          duration: Duration(milliseconds: data["duration"]),
          focusWorkout: data["focusWorkout"],
          progress: data["progress"] != null
              ? ProgressModel.fromMap(data["progress"])
              : null,
          note: data["note"],
          fees: data["fees"],
          extraFee: data["extraFee"],
        ));
      }
      print("End of fetch session in db");
      return sessions;
    });
  }

  Stream<List<SessionModel>> fetchSessionsByClient(ClientModel client) {
    return _db
        .collection('sessions') // Ensure this is your correct collection name
        .where('cid', isEqualTo: client.cid)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              var data = doc.data();
              return SessionModel(
                sid: data["sid"],
                client: client, // Use the provided client instance
                date: (data["date"] as Timestamp).toDate(),
                time: convertMapToTime(data['time']),
                type: data["type"],
                duration: Duration(milliseconds: data["duration"]),
                focusWorkout: data["focusWorkout"],
                progress: data["progress"] != null
                    ? ProgressModel.fromMap(data["progress"])
                    : null,
                note: data["note"],
                fees: data["fees"],
                extraFee: data["extraFee"],
              );
            }).toList());
  }

  //Create receipt
  Future<void> createReceipt(ReceiptModel receipt) async {
    print(receipt.toMap());

    await _db.collection("receipts").doc(receipt.receiptID).set({
      'receiptID': receipt.receiptID,
      'clientName': receipt.clientName,
      'sessions': receipt.sessions,
      'totalAmount': receipt.totalAmount,
      'createdDate': receipt.createdDate,
      'extraFees': receipt.extraFees,
      'discountRate': receipt.discountRate,
      'uid': auth.currentUser!.uid,
    });
  }

  //fetch receipt
  Stream<QuerySnapshot> fetchReceipt() {
    return _db
        .collection('receipts')
        .where('uid', isEqualTo: auth.currentUser!.uid)
        .snapshots();
  }

  Future<void> createProgress(
      sessionID, Map<String, dynamic> progressData) async {
    await _db.collection('sessions').doc(sessionID).update({
      'progress': progressData,
    });
  }
}
