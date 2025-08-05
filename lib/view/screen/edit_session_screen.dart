import 'package:duration_picker/duration_picker.dart';
import 'package:fit_life/view/components/flexible_button.dart';
import 'package:fit_life/view/components/other_input_field.dart';

import 'package:fit_life/view/constant.dart';
import 'package:fit_life/view/theme/app_theme.dart';
import 'package:fit_life/viewModel/session_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditSessionScreen extends StatefulWidget {
  final Map<String, dynamic> session;
  const EditSessionScreen({super.key, required this.session});

  @override
  State<EditSessionScreen> createState() => _EditSessionScreenState();
}

class _EditSessionScreenState extends State<EditSessionScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? sessionType;
  Duration selectedDuration = Duration(hours: 0, minutes: 45);

  bool isFirstTime = false;

  final TextEditingController focusWorkoutController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController hourRateController = TextEditingController();
  final TextEditingController extraFeeController = TextEditingController();
  final TextEditingController sessionTypeController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    selectedDate = widget.session['date'];
    selectedTime = widget.session['time'];
    focusWorkoutController.text =
        convertListToString(widget.session['focusWorkout']);
    selectedDuration = widget.session['duration'];
    noteController.text = widget.session['note'] ?? "";
    sessionTypeController.text = widget.session['type'];
    setState(() {
      isFirstTime = true;
    });
  }

  final List<String> sessionTypes = [
    'Cardio',
    'Strength',
    'Flexibility',
    'Balance'
  ];

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  bool checkIsValid(value) {
    if (isFirstTime) {
      return true;
    } else {
      return value != null;
    }
  }

  @override
  Widget build(BuildContext context) {
    print("This is in edit screen build context");
    final sessionViewModel = Provider.of<SessionViewModel>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Edit Session Form")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Edit",
                style: kPageHeader.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              RichText(
                text: TextSpan(
                  text: "Session",
                  style: kPageHeader.copyWith(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w900,
                  ),
                  children: [
                    TextSpan(
                      text: " For",
                      style: kPageHeader.copyWith(
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Text("Mg Mg",
                  style: kPageHeader.copyWith(
                    fontWeight: FontWeight.w900,
                  )),
              SizedBox(height: 10),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date Picker
                    Text("Date", style: kTextForTextBox),
                    SizedBox(height: 12),
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: OtherInputField(
                        colorValidation: () => checkIsValid(selectedDate),
                        child: Text(
                          selectedDate == null
                              ? "Select Date"
                              : DateFormat('yyyy-MM-dd').format(selectedDate!),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),

                    // Time Picker
                    Text("Time", style: kTextForTextBox),
                    SizedBox(height: 12),

                    GestureDetector(
                      onTap: () => _selectTime(context),
                      child: OtherInputField(
                        colorValidation: () => checkIsValid(selectedTime),
                        child: Text(
                          selectedTime == null
                              ? "Select Time"
                              : selectedTime!.format(context),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),

                    // Session Type Dropdown
                    Text("Session Type", style: kTextForTextBox),
                    SizedBox(height: 12),

                    TextFormField(
                      controller: sessionTypeController,
                      decoration: inputFieldDecoration,
                      validator: (value) => value == null || value.isEmpty
                          ? 'This field is required'
                          : null,
                    ),
                    SizedBox(height: 16),

                    // Other Input Fields
                    Text("Focus Workout", style: kTextForTextBox),
                    SizedBox(height: 12),

                    TextFormField(
                      controller: focusWorkoutController,
                      decoration: inputFieldDecoration,
                      validator: (value) => value == null || value.isEmpty
                          ? 'This field is required'
                          : null,
                    ),
                    SizedBox(height: 16),

                    Text("Duration", style: kTextForTextBox),
                    SizedBox(height: 12),
                    DurationPicker(
                      duration: selectedDuration,
                      onChange: (val) {
                        setState(() {
                          selectedDuration = val;
                        });
                      },
                    ),
                    SizedBox(height: 16),

                    Text("Note", style: kTextForTextBox),
                    SizedBox(height: 12),

                    TextFormField(
                      controller: noteController,
                      decoration: inputFieldDecoration,
                    ),
                    SizedBox(height: 16),

                    Row(
                      children: [
                        FlexibleButton(
                            name: "Save",
                            onTap: () async {
                              setState(() {
                                isFirstTime = false;
                              });
                              if (_formKey.currentState!.validate()) {
                                Map<String, dynamic> updatedSessionData = {
                                  "date": selectedDate,
                                  'time': selectedTime,
                                  'type': sessionTypeController.text,
                                  'focusWorkout': focusWorkoutController.text,
                                  'duration':
                                      selectedDuration, //type - Duration
                                  'note': noteController.text,
                                };

                                await sessionViewModel.updateSession(
                                    widget.session, updatedSessionData);

                                Navigator.pop(context);
                              }
                            }),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
