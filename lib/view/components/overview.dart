import 'package:fit_life/view/constant.dart';
import 'package:fit_life/viewModel/session_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Overview extends StatelessWidget {
  final int clientCount;
  const Overview({super.key, required this.clientCount});

  @override
  Widget build(BuildContext context) {
    final sessionViewModel = Provider.of<SessionViewModel>(context);

    return SizedBox(
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Client",
                        style: kSubTitleText.copyWith(color: Colors.white),
                      ),
                      Text(
                        clientCount.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(width: 25),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Session",
                        style: kSubTitleText.copyWith(color: Colors.white),
                      ),
                      StreamBuilder<int>(
                          stream: sessionViewModel.getSessionCount(),
                          builder: (context, snapshot) {
                            {
                              return Text(
                                "${snapshot.data}",
                                style: TextStyle(color: Colors.white),
                              ); // Display the session count
                            }
                          })
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'chooseClient');
                    },
                    child: Text("Add session"),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'addClient');
                    },
                    child: Text("Add Client"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
