import 'package:fit_life/view/components/flexible_button.dart';
import 'package:fit_life/view/components/session_tile.dart';
import 'package:fit_life/view/constant.dart';
import 'package:fit_life/view/screen/add_session_screen.dart';
import 'package:fit_life/view/screen/receipt_screen.dart';
import 'package:fit_life/view/theme/app_theme.dart';
import 'package:fit_life/viewModel/session_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddSessionScreen2 extends StatefulWidget {
  const AddSessionScreen2({super.key});

  @override
  State<AddSessionScreen2> createState() => _AddSessionScreen2State();
}

class _AddSessionScreen2State extends State<AddSessionScreen2> {
  int? _discountValue;
  @override
  Widget build(BuildContext context) {
    final sessionViewModel = Provider.of<SessionViewModel>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 30,
          bottom: 25,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: "Session",
                style: kPageHeader.copyWith(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w900,
                ),
                children: [
                  TextSpan(
                      text: " you have",
                      style: kPageHeader.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                      )),
                ],
              ),
            ),
            Text(
              "Added",
              style: kPageHeader.copyWith(
                fontWeight: FontWeight.w900,
              ),
            ),
            Row(
              children: [
                Text("Discount"),
                SizedBox(width: 10),
                DropdownButton(
                    value: _discountValue ?? 0,
                    items: [
                      DropdownMenuItem(value: 0, child: Text("0%")),
                      DropdownMenuItem(value: 15, child: Text("15%")),
                      DropdownMenuItem(value: 20, child: Text("20%")),
                      DropdownMenuItem(value: 25, child: Text("25%")),
                      DropdownMenuItem(value: 30, child: Text("30%")),
                      DropdownMenuItem(value: 35, child: Text("35%")),
                      DropdownMenuItem(value: 40, child: Text("40%")),
                      DropdownMenuItem(value: 45, child: Text("45%")),
                      DropdownMenuItem(value: 50, child: Text("50%")),
                      DropdownMenuItem(value: 55, child: Text("55%")),
                      DropdownMenuItem(value: 60, child: Text("60%")),
                      DropdownMenuItem(value: 65, child: Text("65%")),
                      DropdownMenuItem(value: 70, child: Text("70%")),
                      DropdownMenuItem(value: 75, child: Text("75%")),
                      DropdownMenuItem(value: 80, child: Text("80%")),
                      DropdownMenuItem(value: 85, child: Text("85%")),
                      DropdownMenuItem(value: 90, child: Text("90%")),
                      DropdownMenuItem(value: 95, child: Text("95%")),
                      DropdownMenuItem(value: 100, child: Text("100%")),
                    ],
                    onChanged: (newValue) {
                      setState(() {
                        _discountValue = newValue;
                      });
                    }),
              ],
            ),
            Expanded(
              child: Consumer<SessionViewModel>(
                builder: (context, value, child) {
                  return ListView.builder(
                    itemCount: value.chosenSessionList.length,
                    itemBuilder: (context, index) {
                      return SessionTile(
                        session: value.chosenSessionList[index],
                      );
                    },
                  );
                },
              ),
            ),
            Row(
              children: [
                FlexibleButton(
                    name: "Add More",
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddSessionScreen(
                              client: sessionViewModel.chosenClient),
                        ))),
                SizedBox(width: 10),
                FlexibleButton(
                  name: "Get Receipt",
                  color: Colors.green,
                  onTap: () async {
                    await sessionViewModel.addSessionListToDB(
                        discount: _discountValue ?? 0);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReceiptScreen()));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
