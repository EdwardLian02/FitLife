import 'package:fit_life/view/components/receipt_part.dart';
import 'package:fit_life/view/constant.dart';
import 'package:fit_life/view/screen/dashboard_screen.dart';
import 'package:fit_life/view/theme/app_theme.dart';
import 'package:fit_life/viewModel/session_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReceiptScreen extends StatefulWidget {
  const ReceiptScreen({super.key});

  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  @override
  Widget build(BuildContext context) {
    final sessionViewModel = Provider.of<SessionViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Receipt"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Get your",
                      style: kPageHeader.copyWith(fontWeight: FontWeight.w900),
                    ),
                    RichText(
                        text: TextSpan(
                            text: "Receipt",
                            style: kPageHeader.copyWith(
                              fontWeight: FontWeight.w900,
                              color: AppTheme.primaryColor,
                            ),
                            children: [
                          TextSpan(
                            text: " Here",
                            style: kPageHeader.copyWith(
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                            ),
                          )
                        ])),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.download,
                      size: 24,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "Get receipt",
                      style: TextStyle(
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),

            //receipt part
            ReceiptPart(
              receiptObj: sessionViewModel.receiptObj,
              client: sessionViewModel.chosenClient,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                        onTap: () => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DashboardScreen()),
                            (route) => false),
                        child: Icon(Icons.arrow_back_sharp)),
                    SizedBox(width: 4),
                    Text(
                      "Go back to dashboard",
                      style: kRegularFont,
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context)
                          .primaryColor, // Use app's primary color
                    ),
                    child:
                        const Icon(Icons.share, color: Colors.white, size: 24),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
