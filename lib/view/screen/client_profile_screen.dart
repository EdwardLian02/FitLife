import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_life/view/components/session_tile_inProfile.dart';
import 'package:fit_life/view/constant.dart';
import 'package:fit_life/view/screen/edit_client_screen.dart';
import 'package:fit_life/view/screen/session_detail_screen.dart';
import 'package:fit_life/view/theme/app_theme.dart';
import 'package:fit_life/viewModel/client_viewModel.dart';
import 'package:fit_life/viewModel/session_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClientProfileScreen extends StatelessWidget {
  const ClientProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final sessionViewModel = Provider.of<SessionViewModel>(context);
    return Consumer<ClientViewModel>(
      builder: (BuildContext context, value, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.transparent,
            title: Text(
              value.currentClient.name,
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditClientScreen(
                                  client: value.currentClient,
                                )));
                  },
                  child: Row(
                    children: [
                      Icon(Icons.edit),
                      SizedBox(width: 8),
                      Text(
                        "Edit",
                        style: kRegularFont.copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //profile pic
                    ClipRRect(
                      borderRadius: BorderRadius.circular(150),
                      child: Image.asset(
                        'assets/images/user-profile.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 15),
                    //user info
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          value.currentClient.name,
                          style: kRegularFont.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(value.currentClient.phone, style: kRegularFont),
                        SizedBox(height: 6),
                        Text(value.currentClient.email, style: kRegularFont),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Sessions",
                        style: kSubTitleText,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "+ Add More",
                          style: kSmallFont,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppTheme.primaryColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 30),
                      child: StreamBuilder(
                        stream: sessionViewModel
                            .fetchSessionByClientID(value.currentClient),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                                child:
                                    CircularProgressIndicator()); // Show a loading indicator while waiting for data
                          }
                          if (snapshot.hasError) {
                            return Text("Error: ${snapshot.error}");
                          }
                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return Center(
                                child: Text(
                              "No session available",
                              style: TextStyle(color: Colors.white),
                            )); // Handle empty data
                          }

                          final sessionList = snapshot.data!;

                          return ListView.builder(
                              itemCount: sessionList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () async {
                                    Map<String, dynamic> progressData = {};
                                    if (sessionList[index].progress != null) {
                                      progressData =
                                          sessionList[index].progress!.toMap();
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
                                      'date':
                                          (sessionList[index].date is Timestamp)
                                              ? (sessionList[index].date
                                                      as Timestamp)
                                                  .toDate()
                                              : sessionList[index].date,
                                      'time': sessionList[index].time,
                                      'clientName':
                                          sessionList[index].client.name,
                                      'duration': sessionList[index]
                                          .duration, //type - Duration
                                      'focusWorkout':
                                          sessionList[index].focusWorkout,
                                      'progress': progressData,
                                      'note': sessionList[index].note,
                                    });

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SessionDetailScreen(),
                                        ));
                                  },
                                  child: SessionTileInprofile(
                                    session: sessionList[index],
                                  ),
                                );
                              });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
