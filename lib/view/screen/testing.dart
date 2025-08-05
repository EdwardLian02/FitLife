import 'package:flutter/material.dart';

class Testing extends StatelessWidget {
  const Testing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: const Text("Receipt")),
      body: Center(
        child: Container(
          width: 350,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 2),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Receipt Header
              Text(
                "MY GYM CENTER",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                "123 Street, Yangon, Myanmar",
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              const Divider(thickness: 1),

              /// Customer Details
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Customer: John Doe", style: TextStyle(fontSize: 14)),
                    Text("Date: 05-Feb-2025", style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              /// Table Header
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                color: Colors.grey[300],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    SizedBox(
                        width: 120,
                        child: Text("Service",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    SizedBox(
                        width: 60,
                        child: Text("Hours",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    SizedBox(
                        width: 80,
                        child: Text("Cost",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                ),
              ),

              /// Items List
              const TestingItem(
                  service: "Cardio", hours: "2hr", cost: "5,000 MMK"),
              const TestingItem(
                  service: "Swimming", hours: "1.5hr", cost: "7,000 MMK"),
              const TestingItem(
                  service: "Gym", hours: "3hr", cost: "10,000 MMK"),
              const Divider(thickness: 1),

              /// Total Price
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Total",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text("22,000 MMK",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),

              /// Print Button
              ElevatedButton(
                onPressed: () {
                  // Printing logic can be added here
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Printing Receipt...")),
                  );
                },
                child: const Text("Print Receipt"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TestingItem extends StatelessWidget {
  final String service;
  final String hours;
  final String cost;

  const TestingItem(
      {super.key,
      required this.service,
      required this.hours,
      required this.cost});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 120, child: Text(service)),
          SizedBox(width: 60, child: Text(hours)),
          SizedBox(width: 80, child: Text(cost)),
        ],
      ),
    );
  }
}
