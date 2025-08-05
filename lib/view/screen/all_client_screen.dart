import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_life/model/client.dart';
import 'package:fit_life/view/components/client_tile.dart';
import 'package:fit_life/view/constant.dart';
import 'package:fit_life/view/screen/client_profile_screen.dart';
import 'package:fit_life/viewModel/client_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllClientScreen extends StatelessWidget {
  const AllClientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final clientViewModel = Provider.of<ClientViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: false,
        title: Text(
          "All Clients",
          style: kFont20.copyWith(
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                  final clientData =
                      clientList[index].data() as Map<String, dynamic>;
                  clientData["createdDate"] =
                      (clientData["createdDate"] as Timestamp).toDate();

                  final client = ClientModel.fromMap(clientData);

                  return GestureDetector(
                    onTap: () {
                      clientViewModel.currentClient = client;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ClientProfileScreen(),
                        ),
                      );
                    },
                    child: ClientTile(
                      client: client,
                      onDelete: () => clientViewModel.deleteClient(client.cid),
                    ),
                  );
                },
              );
            } else {
              return Text("There is no client");
            }
          },
        ),
      ),
    );
  }
}
