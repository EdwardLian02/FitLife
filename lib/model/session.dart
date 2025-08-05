import 'package:fit_life/model/client.dart';
import 'package:fit_life/model/progress.dart';
import 'package:flutter/material.dart';

class SessionModel {
  String sid;

  final ClientModel client;
  final DateTime date;
  final TimeOfDay time;
  final String type;
  final Duration duration;
  final String focusWorkout;
  final ProgressModel? progress;
  final String? note;
  final int fees;
  final int extraFee;

  SessionModel({
    required this.sid,
    required this.client,
    required this.date,
    required this.time,
    required this.type,
    required this.duration,
    required this.focusWorkout,
    this.progress,
    this.note,
    required this.fees,
    required this.extraFee,
  });

  @override
  String toString() {
    return "\nID: $sid \nClient: $client \nDate: $date \nTime: $time \nType: $type \nDuration: $duration \nFocusWorkout: $focusWorkout \nProgress: $progress \nNote: $note \nHourlyRate: $fees \nExtraFee: $extraFee";
  }

  Map<String, dynamic> toMap() => {
        "sid": sid,
        "client": client,
        "date": date,
        "time": time,
        "type": type,
        "duration": duration,
        "focusWorkout": focusWorkout,
        "progress": {},
        "note": note,
        "hourlyRate": fees,
        "extraFee": extraFee,
      };

  factory SessionModel.fromMap(Map<String, dynamic> data) {
    return SessionModel(
      sid: data["sid"],
      client: data["client"],
      date: data["date"],
      time: data["time"],
      type: data['type'],
      duration: data['duration'],
      focusWorkout: data['focusWorkout'],
      progress: data['progress'] != null
          ? ProgressModel.fromMap(data['progress'])
          : null,
      note: data['note'],
      fees: data['fees'],
      extraFee: data['extraFee'],
    );
  }
}
