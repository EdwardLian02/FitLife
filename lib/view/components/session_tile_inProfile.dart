import 'package:fit_life/model/session.dart';
import 'package:flutter/material.dart';
import 'package:fit_life/view/constant.dart';
import 'package:intl/intl.dart';

class SessionTileInprofile extends StatelessWidget {
  final SessionModel session;
  const SessionTileInprofile({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      textColor: Colors.white,
      title: Text(
        session.type,
        style: kFont20,
      ),
      subtitle: Text(
        session.time.format(context),
        style: kRegularFont,
      ),
      trailing: Text(DateFormat("d MMM, y").format(session.date),
          style: kRegularFont.copyWith(
            fontSize: 15,
            color: const Color.fromARGB(255, 220, 219, 219),
          )),
    );
  }
}
