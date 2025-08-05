import 'package:fit_life/model/session.dart';
import 'package:fit_life/view/constant.dart';
import 'package:fit_life/view/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SessionTile extends StatelessWidget {
  final SessionModel session;

  const SessionTile({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.primaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          child: ListTile(
            textColor: Colors.white,
            title: Text(
              session.type,
              style: kFont20,
            ),
            subtitle: Text(
              session.client.name,
              style: kRegularFont,
            ),
            trailing: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center align the text vertically
              crossAxisAlignment:
                  CrossAxisAlignment.end, // Align text to the end horizontally
              children: [
                Text(DateFormat("d MMM, y").format(session.date),
                    style: kRegularFont.copyWith(
                      fontSize: 15,
                      color: const Color.fromARGB(255, 220, 219, 219),
                    )),
                SizedBox(height: 8),
                Text(session.time.format(context),
                    style: kRegularFont.copyWith(
                      fontSize: 12,
                      color: const Color.fromARGB(255, 220, 219, 219),
                    )), // Add the date here
              ],
            ),
          ),
        ),
      ),
    );
  }
}
