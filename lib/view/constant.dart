import 'package:flutter/material.dart';

const kTitleStyle = TextStyle(
  fontFamily: 'Roboto',
  fontSize: 30,
  color: Color(0xFF69C5EF),
  fontWeight: FontWeight.w900,
);

const kPageHeader = TextStyle(
  fontFamily: 'Roboto',
  fontSize: 30,
  fontWeight: FontWeight.normal,
);

const kTextForTextBox = TextStyle(
  fontFamily: 'Roboto',
  fontSize: 15,
  color: Color.fromRGBO(0, 0, 0, 0.4),
);

const kSubTitleText = TextStyle(
  fontFamily: 'Roboto',
  fontSize: 18,
  color: Colors.black,
  fontWeight: FontWeight.w400,
);

const kFont20 = TextStyle(
  fontSize: 20,
  fontFamily: "Roboto",
  fontWeight: FontWeight.w500,
);

const kRegularFont = TextStyle(
  fontFamily: "Roboto",
  fontSize: 16,
);

const kSmallFont = TextStyle(
  fontFamily: "Roboto",
  fontSize: 13,
);

var inputFieldDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(6),
    borderSide: BorderSide(
      color: Color(0xFFB0AEAE), // Normal border color
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(6),
    borderSide: const BorderSide(
      color: Color(0xFF7D59EE), // Focus border color
      width: 2.0,
    ),
  ),
);

TimeOfDay convertMapToTime(Map<String, dynamic> time) {
  // Convert to TimeOfDay directly without changing the hour format
  return TimeOfDay(
    hour: time["hour"] % 12 + (time["period"] == "PM" ? 12 : 0),
    minute: time["minute"],
  );
}

Map<String, dynamic> converTimeToMap(TimeOfDay time) {
  return {
    "hour": time.hour,
    "minute": time.minute,
    "period": time.period == DayPeriod.am ? "AM" : "PM",
  };
}

List<String> convertStringToList(String value) {
  return value.split(',').map((word) => word.trim()).toList();
}

String convertListToString(List<String> words) {
  return words.join(', ');
}
