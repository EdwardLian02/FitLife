import 'package:fit_life/view/components/expendable_text.dart';
import 'package:fit_life/view/components/flexible_button.dart';
import 'package:fit_life/view/components/focus_workout_tile.dart';
import 'package:fit_life/view/components/progress_display.dart';
import 'package:fit_life/view/constant.dart';
import 'package:fit_life/view/screen/create_progress_screen.dart';
import 'package:fit_life/view/screen/edit_session_screen.dart';
import 'package:fit_life/view/theme/app_theme.dart';
import 'package:fit_life/viewModel/session_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SessionDetailScreen extends StatelessWidget {
  const SessionDetailScreen({super.key});

  void _showDeleteConfirmation(BuildContext context, sessionID) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: const [
            Icon(Icons.confirmation_num_outlined, color: Colors.red, size: 30),
            SizedBox(width: 10),
            Text("Confirmation", style: TextStyle(color: Colors.red)),
          ],
        ),
        content: Text(
          "Are you sure you want to delete the session",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Cancel
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () async {
              SessionViewModel sessionVM = SessionViewModel();
              await sessionVM.deleteSession(sessionID);
              Navigator.pushNamedAndRemoveUntil(
                context,
                'dashboard',
                (route) => false, // Remove all previous routes
              );
            },
            child: const Text("Yes", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Consumer<SessionViewModel>(
              builder: (context, value, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/images/trainer-image.png",
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Session Type",
                            style: kPageHeader,
                          ),
                          Text(
                            value.sessionForDetail['type'],
                            style: kPageHeader.copyWith(
                                color: AppTheme.primaryColor,
                                fontWeight: FontWeight.w900),
                          ),
                          SizedBox(height: 34),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                DateFormat("d MMM, y")
                                    .format(value.sessionForDetail['date']),
                                style: kFont20.copyWith(
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xFFB0AEAE)),
                              ),
                              Text(
                                value.sessionForDetail['time'].format(context),
                                style: kFont20.copyWith(
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xFFB0AEAE),
                                ),
                              ),
                            ],
                          ),
                          Divider(color: Color(0xFFB0AEAE)),

                          //User info section
                          SizedBox(height: 12),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Client: ",
                                  style: kFont20.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: value.sessionForDetail['clientName'],
                                  style: kFont20.copyWith(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Duration: ",
                                  style: kFont20.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      "${value.sessionForDetail['duration'].inHours}hr ${value.sessionForDetail['duration'].inMinutes % 60}min",
                                  style: kFont20.copyWith(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 23),

                          //Focus workout section
                          Text(
                            "Focus Workout",
                            style: kFont20.copyWith(
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 20),
                          Wrap(
                            spacing: 10, // Space between items
                            runSpacing: 10, // Space between rows
                            children: [
                              for (var tile
                                  in value.sessionForDetail['focusWorkout'])
                                FocusWorkoutTile(text: tile),
                            ],
                          ),
                          SizedBox(height: 20),
                          //Progress section
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Progress",
                                style: kFont20.copyWith(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CreateProgressScreen(
                                              sessionData:
                                                  value.sessionForDetail,
                                            ))),
                                child: Icon(
                                  Icons.edit_document,
                                  size: 25,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          ProgressDisplay(),
                          SizedBox(height: 20),
                          ExpandableText(
                              text:
                                  "Remark: ${value.sessionForDetail['note']}"),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              FlexibleButton(
                                name: "Edit",
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditSessionScreen(
                                        session: value.sessionForDetail,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(width: 10),
                              FlexibleButton(
                                name: "Delete",
                                color: Color(0xFFFF0000),
                                onTap: () => _showDeleteConfirmation(
                                  context,
                                  value.sessionForDetail['sid'],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
