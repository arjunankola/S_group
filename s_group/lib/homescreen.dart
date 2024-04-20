import 'package:flutter/material.dart';
import 'package:s_group/attendance_page.dart';
import 'package:s_group/billspage.dart';
import 'package:s_group/employees_pade.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // Adjust the height as needed
        child: AppBar(
          backgroundColor: Color(0xFF274060),
          title: Row(
            children: [
              Image.asset("assets/2.png", height: 150, width: 150), // Adjust image size as needed
              Text(
                'Somnath Industries',
                style: TextStyle(fontSize: 20, color: Colors.white), // Adjust the font size as needed
              ),
            ],
          ),
        ),
      ),
      body: _getBody(_selectedIndex), // Displaying body based on selected index
      
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.event), // Custom icon for attendance
            label: 'Attendance',
          ),
          BottomNavigationBarItem(
             // Custom icon for inventory
            label: 'Bills',
            icon: Icon( Icons.receipt_long_outlined)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people), // Custom icon for employees
            label: 'Employees',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF274060),
        unselectedItemColor: Colors.grey, // Color for unselected items
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _getBody(int index) {
    switch (index) {
      case 0:
        return AttendancePage();
      case 1:
        return BillsPage();
      case 2:
        return EmployeesPage();
      default:
        return Container();
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}
