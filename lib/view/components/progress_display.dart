import 'package:fit_life/view/constant.dart';
import 'package:fit_life/view/theme/app_theme.dart';
import 'package:fit_life/viewModel/session_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProgressDisplay extends StatelessWidget {
  const ProgressDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SessionViewModel>(
      builder: (context, value, child) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppTheme.primaryColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            // Ensures the Column is centered within the Container
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Centers rows inside column
                children: [
                  buildRow(
                    "Sets",
                    value.sessionForDetail['progress']['set'],
                  ),
                  SizedBox(height: 10),
                  buildRow(
                    "Reps",
                    value.sessionForDetail['progress']['rep'],
                  ),
                  SizedBox(height: 10),
                  buildRow("Weights",
                      "${value.sessionForDetail['progress']['weights']} kg"),
                  SizedBox(height: 10),
                  buildRow("Burn calories",
                      "${value.sessionForDetail['progress']['burnCalories']} cal"),
                  SizedBox(height: 10),
                  buildRow("Distance run",
                      "${value.sessionForDetail['progress']['distanceRun']} km"),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Helper function to create aligned rows
  Widget buildRow(String label, String value) {
    return Row(
      mainAxisSize:
          MainAxisSize.min, // Ensures the row does not stretch to full width
      children: [
        SizedBox(
          width: 150, // Fixed width for label alignment
          child: Text(
            label,
            style: kFont20.copyWith(color: Colors.white),
          ),
        ),
        Text(
          value,
          style: kFont20.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w100,
          ),
        ),
      ],
    );
  }
}
