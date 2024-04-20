import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class EmployeesPage extends StatefulWidget {
  @override
  _EmployeesPageState createState() => _EmployeesPageState();
}

class _EmployeesPageState extends State<EmployeesPage> {
  List<Map<String, dynamic>> _employees = [];

  @override
  void initState() {
    super.initState();
    _loadEmployees();
  }

  _loadEmployees() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? employeesJson = prefs.getString('employees');
    if (employeesJson != null) {
      setState(() {
        _employees = json.decode(employeesJson).cast<Map<String, dynamic>>();
      });
    }
  }

  _saveEmployees() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('employees', json.encode(_employees));
    print('Employees saved $_employees');
    _loadEmployees();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employees'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _employees.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _showEditEmployeeDialog(index);
                  },
                  child: ListTile(
                    title: Text(_employees[index]['name'] ?? ''),
                    subtitle:
                        Text('Salary: ${_employees[index]['salary'] ?? ''}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          _employees.removeAt(index);
                          _saveEmployees();
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                _showAddEmployeeDialog();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF274060),
                foregroundColor: Colors.white,
              ),
              child: Text(
                'Add Employee',
                style:
                    TextStyle(color: Colors.white), // Set text color to white
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddEmployeeDialog() {
    TextEditingController nameController = TextEditingController();
    TextEditingController salaryController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Add Employee',
            style: TextStyle(
                color: Color(0xFF274060), fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: salaryController,
                decoration: InputDecoration(labelText: 'Salary'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFF274060)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white)),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (nameController.text.isNotEmpty &&
                    salaryController.text.isNotEmpty) {
                  _employees.add({
                    'name': nameController.text,
                    'salary': double.tryParse(salaryController.text) ?? 0.0,
                  });
                  _saveEmployees();
                  await FirebaseFirestore.instance
                      .collection('employees_data')
                      .add({
                    'emp_name': nameController.text,
                    'emp_salary': double.tryParse(salaryController.text) ?? 0.0,
                    // Calculate total price
                  });

                  Navigator.of(context).pop();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF274060),
                foregroundColor: Colors.white,
              ),
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showEditEmployeeDialog(int index) {
    TextEditingController nameController =
        TextEditingController(text: _employees[index]['name']);
    TextEditingController salaryController = TextEditingController(
        text: _employees[index]['salary']?.toString() ?? '');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Employee'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                    labelText: 'Name', focusColor: Color(0xFF274060)),
              ),
              TextField(
                controller: salaryController,
                decoration: InputDecoration(
                  labelText: 'Salary',
                  focusColor: Color(0xFF274060),
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFF274060)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white)),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    salaryController.text.isNotEmpty) {
                  _employees[index]['name'] = nameController.text;
                  _employees[index]['salary'] =
                      double.tryParse(salaryController.text) ?? 0.0;
                  _saveEmployees();
                  Navigator.of(context).pop();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF274060),
              ),
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
