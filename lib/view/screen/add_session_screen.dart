import 'package:duration_picker/duration_picker.dart';
import 'package:fit_life/model/client.dart';
import 'package:fit_life/model/session.dart';
import 'package:fit_life/view/components/flexible_button.dart';
import 'package:fit_life/view/components/other_input_field.dart';
import 'package:fit_life/view/constant.dart';
import 'package:fit_life/view/theme/app_theme.dart';
import 'package:fit_life/viewModel/session_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddSessionScreen extends StatefulWidget {
  final ClientModel client;
  const AddSessionScreen({super.key, required this.client});

  @override
  State<AddSessionScreen> createState() => _AddSessionScreenState();
}

class _AddSessionScreenState extends State<AddSessionScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  Duration selectedDuration = Duration(hours: 0, minutes: 45);

  final TextEditingController sessionTypeController = TextEditingController();
  final TextEditingController focusWorkoutController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController feeController = TextEditingController();
  final TextEditingController extraFeeController = TextEditingController();

  bool isFirstTime = false;

  @override
  void initState() {
    super.initState();
    extraFeeController.text = "0";
    setState(() {
      isFirstTime = true;
    });
  }

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
    final sessionViewModel = Provider.of<SessionViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Add Session Form")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: "Add ",
                  style: kPageHeader.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                  ),
                  children: [
                    TextSpan(
                      text: "Session",
                      style: kPageHeader.copyWith(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
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
              Text(widget.client.name,
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

                    // Session Type
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

                    Text("Note", style: kTextForTextBox),
                    SizedBox(height: 12),

                    TextFormField(
                      controller: noteController,
                      decoration: inputFieldDecoration,
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hourly Rate - MMK",
                                style: kTextForTextBox,
                              ),
                              SizedBox(height: 12),
                              TextFormField(
                                controller: feeController,
                                decoration: inputFieldDecoration,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter hourly rate';
                                  }
                                  if (double.tryParse(value) == null) {
                                    return 'Please enter a valid number';
                                  }
                                  if (double.parse(value) <= 0) {
                                    return ' must be greater than 0';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Extra Fee - MMK", style: kTextForTextBox),
                              SizedBox(height: 12),
                              TextFormField(
                                controller: extraFeeController,
                                decoration: inputFieldDecoration,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter hourly rate';
                                  }
                                  if (double.tryParse(value) == null) {
                                    return 'Please enter a valid number';
                                  }

                                  if (double.parse(value) < 0) {
                                    return ' must be greater than 0';
                                  }

                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

                    Row(
                      children: [
                        FlexibleButton(
                            name: "Add",
                            onTap: () {
                              //For the input color changing for "date" and "time" field.
                              setState(() {
                                isFirstTime = false;
                              });
                              if (_formKey.currentState!.validate() &&
                                  selectedDate != null &&
                                  selectedTime != null) {
                                final session = SessionModel.fromMap({
                                  "sid": "later",
                                  "client": widget.client,
                                  "date": selectedDate,
                                  "time": selectedTime,
                                  "type": sessionTypeController.text,
                                  "focusWorkout": focusWorkoutController.text,
                                  "duration": selectedDuration,
                                  "fees": int.parse(feeController.text),
                                  "extraFee":
                                      int.parse(extraFeeController.text),
                                  'note': noteController.text.trim(),
                                });
                                print("Successfully added a new session");
                                sessionViewModel.addSession(session);
                                Navigator.pushReplacementNamed(
                                    context, "addSession2");
                              }
                            }),
                      ],
                    ),
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
