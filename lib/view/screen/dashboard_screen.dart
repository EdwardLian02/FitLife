import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_life/view/components/overview.dart';
import 'package:fit_life/view/components/session_tile.dart';
import 'package:fit_life/view/constant.dart';
import 'package:fit_life/view/screen/all_receipts.dart';
import 'package:fit_life/view/screen/all_session_screen.dart';
import 'package:fit_life/view/screen/session_detail_screen.dart';
import 'package:fit_life/view/theme/app_theme.dart';
import 'package:fit_life/viewModel/auth_viewModel.dart';
import 'package:fit_life/viewModel/client_viewModel.dart';
import 'package:fit_life/viewModel/session_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ClientViewModel>(context, listen: false).getClientCount();
    Future.microtask(() {
      final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

      authViewModel.saveCurrentLoginUser();
    });
  }

  void onDelete(clientID) async {
    await Provider.of<ClientViewModel>(context, listen: false)
        .deleteClient(clientID);
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final sessionViewModel = Provider.of<SessionViewModel>(context);
    final clientViewModel = Provider.of<ClientViewModel>(context);
    final currentUser = authViewModel.user;

    print(currentUser?.name);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFF6F6F6),
          centerTitle: false,
          title: Text(
            "Dashboard",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'userProfile'),
                child: Text(
                  currentUser != null
                      ? "Hello ${currentUser.name}"
                      : "loading...",
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(
                color: const Color.fromARGB(255, 207, 206, 206),
              ),
              //Overview section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Overview", style: kSubTitleText),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AllReceipts()),
                      );
                    },
                    child: Text(
                      "View Receipts",
                      style: TextStyle(
                        fontSize: 16,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 15),
              Overview(
                clientCount: clientViewModel.clientCount,
              ),
              SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'allClient');
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color:
                        Colors.white.withOpacity(0.1), // Light background color
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                    border: Border.all(
                      color: AppTheme.primaryColor, // Border color
                      width: 1.5, // Border width
                    ),
                  ),
                  child: Text(
                    "All Client",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.w500, // Slightly bold text
                    ),
                  ),
                ),
              ),

              //up-coming session section
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Up-coming Session",
                    style: kSubTitleText,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AllSessionScreen(),
                          ),
                        ),
                        child: Text("More",
                            style:
                                kTextForTextBox.copyWith(color: Colors.grey)),
                      ),
                      Icon(Icons.arrow_right_outlined),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 15),
              //Displaying sessions
              Expanded(
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
                      return Center(
                          child: Text(
                              "No session available")); // Handle empty data
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
                              'date': (sessionList[index].date is Timestamp)
                                  ? (sessionList[index].date as Timestamp)
                                      .toDate()
                                  : sessionList[index].date,
                              'time': sessionList[index].time,
                              'clientName': sessionList[index].client.name,
                              'duration':
                                  sessionList[index].duration, //type - Duration
                              'focusWorkout': convertStringToList(
                                  sessionList[index].focusWorkout),
                              'progress': progressData,
                              'note': sessionList[index].note,
                            });

                            print("I am bout to change screen");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SessionDetailScreen()));
                          },
                          child: SessionTile(
                            session: sessionList[index],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              // //Recent Client section
            ],
          ),
        ));
  }
}
