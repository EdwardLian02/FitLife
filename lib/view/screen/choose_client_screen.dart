import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_life/model/client.dart';
import 'package:fit_life/view/components/client_tile.dart';
import 'package:fit_life/view/components/flexible_button.dart';
import 'package:fit_life/view/constant.dart';
import 'package:fit_life/view/screen/add_session_screen.dart';
import 'package:fit_life/view/theme/app_theme.dart';
import 'package:fit_life/viewModel/client_viewModel.dart';
import 'package:fit_life/viewModel/session_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChooseClientScreen extends StatelessWidget {
  const ChooseClientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final clientViewModel = Provider.of<ClientViewModel>(context);
    final sessionViewModel = Provider.of<SessionViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Please",
              style: kPageHeader.copyWith(fontWeight: FontWeight.w900),
            ),
            RichText(
              text: TextSpan(
                text: "Choose",
                style: kPageHeader.copyWith(
                  fontWeight: FontWeight.w900,
                  color: AppTheme.primaryColor,
                ),
                children: [
                  TextSpan(
                    text: " a client",
                    style: kPageHeader.copyWith(
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(300),
                color: Colors.black,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 3),
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, 'addClient'),
                  child: Text(
                    "New",
                    style: kFont20.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: StreamBuilder(
                stream: clientViewModel.fetchClient(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  }

                  if (snapshot.hasData) {
                    final clientList = snapshot.data!.docs;

                    return ListView.builder(
                      itemCount: clientList.length,
                      itemBuilder: (context, index) {
                        //Ensure to clean chosen session list from the previous
                        sessionViewModel.chosenSessionList = [];

                        //Choose a client
                        final clientData =
                            clientList[index].data() as Map<String, dynamic>;
                        clientData["createdDate"] =
                            (clientData["createdDate"] as Timestamp).toDate();
                        final client = ClientModel.fromMap(clientData);
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddSessionScreen(
                                    client: client,
                                  ),
                                ));
                          },
                          child: ClientTile(
                            client: client,
                            onDelete: () =>
                                clientViewModel.deleteClient(client.cid),
                          ),
                        );
                      },
                    );
                  } else {
                    return Text("There is no client!");
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                children: [
                  FlexibleButton(name: "Next", onTap: () {}),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
