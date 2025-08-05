import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_life/view/components/session_tile.dart';
import 'package:fit_life/view/constant.dart';
import 'package:fit_life/view/screen/session_detail_screen.dart';
import 'package:fit_life/viewModel/session_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllSessionScreen extends StatelessWidget {
  const AllSessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sessionViewModel = Provider.of<SessionViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "All Sessions",
          style: kFont20.copyWith(
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: StreamBuilder(
          stream: sessionViewModel.fetchSessions(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child:
                      CircularProgressIndicator()); // Show a loading indicator while waiting for data
            }

            if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("No session available"));
            }
            final sessionList = snapshot.data!;

            return ListView.builder(
              itemCount: sessionList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    Map<String, dynamic> progressData = {};
                    if (sessionList[index].progress != null) {
                      progressData = sessionList[index].progress!.toMap();
                    } else {
                      progressData = {
                        'set': '0',
                        'rep': '0',
                        'weights': '0',
                        'burnCalories': '0',
                        'distanceRun': '0',
                      };
                    }

                    sessionViewModel.assignSessionDetail({
                      'sid': sessionList[index].sid,
                      'type': sessionList[index].type,
                      'date': (sessionList[index].date is Timestamp)
                          ? (sessionList[index].date as Timestamp).toDate()
                          : sessionList[index].date,
                      'time': sessionList[index].time,
                      'clientName': sessionList[index].client.name,
                      'duration': sessionList[index].duration, //type - Duration
                      'focusWorkout': sessionList[index].focusWorkout,
                      'progress': progressData,
                      'note': sessionList[index].note,
                    });

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SessionDetailScreen()));
                  },
                  child: SessionTile(session: sessionList[index]),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
