import 'package:flutter/material.dart';

class CalendarPage extends StatefulWidget {
  final String userName;
  final int salary;

  CalendarPage({required this.userName, required this.salary});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late DateTime _selectedDate;
  final Map<int, bool> _isHoveredMap = {};
  final Map<int, Color> _dayColorsMap = {};

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final int daysInMonth = DateTime(_selectedDate.year, _selectedDate.month + 1, 0).day;

    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar for ${widget.userName}'),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              showSummaryDialog();
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF3C4CAD), Color(0xFF240E8B)], // Gradient colors
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 1.0,
            ),
            itemCount: daysInMonth,
            itemBuilder: (context, index) {
              final day = index + 1;

              return MouseRegion(
                onEnter: (_) {
                  setState(() {
                    _isHoveredMap[day] = true;
                  });
                },
                onExit: (_) {
                  setState(() {
                    _isHoveredMap[day] = false;
                  });
                },
                child: Card(
                  color: _dayColorsMap[day] ?? Colors.blue,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Center(
                          child: Text(
                            '$day',
                            style: TextStyle(fontSize: 16.0, color: Colors.white),
                          ),
                        ),
                        if (_isHoveredMap[day] ?? false)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    // Set the color to red
                                    _dayColorsMap[day] = Colors.red;
                                  });
                                },
                                icon: Icon(Icons.close_rounded, color: _dayColorsMap[day] == Colors.red ? Colors.white : Colors.red, size: 40),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    // Set the color to green
                                    _dayColorsMap[day] = Colors.green;
                                  });
                                },
                                icon: Icon(Icons.check_box, color: _dayColorsMap[day] == Colors.green ? Colors.white : Colors.green, size: 40),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void showSummaryDialog() {
    // Calculate the summary data
    int presentDays = _dayColorsMap.values.where((color) => color == Colors.green).length;
    int absentDays = _dayColorsMap.values.where((color) => color == Colors.red).length;
    int remainingDays = DateTime(_selectedDate.year, _selectedDate.month + 1, 0).day - presentDays - absentDays;

    int dailySalary = widget.salary as int; // Assuming salary is per day
    int totalSalary = presentDays * dailySalary;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Attendance Summary'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Present Days: $presentDays'),
              Text('Absent Days: $absentDays'),
              Text('Remaining Days: $remainingDays'),
              SizedBox(height: 16.0),
              Text('Daily Salary: \₹${widget.salary}'),
              Text('Total Salary: \₹${totalSalary.toString()}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
