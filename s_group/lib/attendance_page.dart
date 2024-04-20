import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AttendancePage extends StatefulWidget {
  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  late List<int> daysInMonth;
  late int selectedDayIndex;
  List<String> employees = [
  ];
  late List<bool> isPresent;

  @override
  void initState() {
    super.initState();
    // Get the current month and its number of days
    DateTime now = DateTime.now();
    selectedDayIndex = -1;
    daysInMonth = List<int>.generate(
        DateTime(now.year, now.month + 1, 0).day,
        (index) => index + 1);
    // Initialize attendance status for each employee
    isPresent = List<bool>.filled(employees.length, false);
    _loadEmployeesFromFirestore();
  }

  _loadEmployeesFromFirestore() async {
  // Retrieve employees collection from Firestore
  QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance.collection('employees_data').get();

  // Extract employee names from the query snapshot
  List<String> employeeNames = querySnapshot.docs
      .map((doc) => doc.data()['emp_name'] as String)
      .toList();

  setState(() {
    // Update employees list with data from Firestore
    employees = employeeNames;
    // Update attendance list size based on the number of employees
    isPresent = List<bool>.filled(employees.length, false);
  });
}

  _saveAttendance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('attendance', json.encode(isPresent));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 50,
            color: Colors.blue, // Adjust color as needed
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: daysInMonth.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDayIndex = index;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selectedDayIndex == index ? Color(0xFF274060) : Colors.white,
                        width: 2,
                      ),
                      color: selectedDayIndex == index ? Colors.white : Color(0xFF274060),
                    ),
                    child: Text(
                      '${daysInMonth[index]}',
                      style: TextStyle(
                        color: selectedDayIndex == index ? Color(0xFF274060) : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: selectedDayIndex == -1
                ? Center(child: Text('Select a day'))
                : ListView.builder(
                    itemCount: employees.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(employees[index]),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  // Toggle attendance status
                                  isPresent[index] = true;
                                  _saveAttendance();
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isPresent[index] ? Colors.green : null,
                              ),
                              child: Text('Present'),
                            ),
                            SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  // Toggle attendance status
                                  isPresent[index] = false;
                                  _saveAttendance();
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isPresent[index] ? null : Colors.red,
                              ),
                              child: Text('Absent'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
