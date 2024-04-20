// import 'package:flutter/material.dart';
// import 'package:s_group/calendar.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class UserListPage extends StatefulWidget {
//   final List<User> userList;

//   UserListPage({required this.userList});

//   @override
//   _UserListPageState createState() => _UserListPageState(userList);
// }

// class _UserListPageState extends State<UserListPage> {
//   late List<User> userList;

//   _UserListPageState(this.userList);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User List'),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Color(0xFF3C4CAD),Color(0xFF240E8B)], // Gradient colors
//           ),
//         ),
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: ListView.builder(
//             itemCount: userList.length,
//             itemBuilder: (context, index) {
//               return UserCard(
//                 user: userList[index],
//                 onEditPressed: () {
//                   _editUser(context, index);
//                 },
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _editUser(BuildContext context, int index) async {
//     TextEditingController nameController =
//         TextEditingController(text: userList[index].name);
//     TextEditingController salaryController =
//         TextEditingController(text: userList[index].salary.toString());

//     SharedPreferences prefs = await SharedPreferences.getInstance();

//     User? updatedUser = await showDialog<User>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Edit User'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: nameController,
//                 decoration: InputDecoration(labelText: 'Name'),
//               ),
//               TextField(
//                 controller: salaryController,
//                 decoration: InputDecoration(labelText: 'Salary'),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 String name = nameController.text;
//                 int salary = int.parse(salaryController.text);

//                 // Save updated user data to SharedPreferences
//                 prefs.setString('user_name_$index', name);
//                 prefs.setInt('user_salary_$index', salary);

//                 Navigator.of(context).pop(User(name: name, salary: salary));
//               },
//               child: Text('Save'),
//             ),
//           ],
//         );
//       },
//     );

//     if (updatedUser != null) {
//       setState(() {
//         userList[index] = updatedUser;
//       });
//     }
//   }
// }

// class UserCard extends StatelessWidget {
//   final User user;
//   final VoidCallback onEditPressed;

//   UserCard({required this.user, required this.onEditPressed});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => CalendarPage(userName: user.name, salary: user.salary)),
//         );
//       },
//       child: Card(
//         elevation: 4.0,
//         margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         child: ListTile(
//           contentPadding: EdgeInsets.all(16.0),
//           title: Text(
//             user.name,
//             style: TextStyle(
//               fontSize: 18.0,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           subtitle: Text(
//             'Salary: ₹${user.salary}',
//             style: TextStyle(
//               fontSize: 16.0,
//               fontStyle: FontStyle.italic,
//             ),
//           ),
//           leading: CircleAvatar(
//             backgroundColor: Colors.indigo,
//             child: Text(
//               user.name.substring(0, 1),
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 24.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           trailing: IconButton(
//             icon: Icon(Icons.edit),
//             onPressed: onEditPressed,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class User {
//   final String name;
//   final int salary;

//   User({required this.name, required this.salary});
// }
import 'package:flutter/material.dart';
import 'package:s_group/calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserListPage extends StatefulWidget {
  final List<User> userList;

  UserListPage({required this.userList});

  @override
  _UserListPageState createState() => _UserListPageState(userList);
}

class _UserListPageState extends State<UserListPage> {
  late List<User> userList;

  _UserListPageState(this.userList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
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
          padding: EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: userList.length,
            itemBuilder: (context, index) {
              return UserCard(
                user: userList[index],
                onEditPressed: () {
                  _editUser(context, index);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _editUser(BuildContext context, int index) async {
    TextEditingController nameController =
        TextEditingController(text: userList[index].name);
    TextEditingController salaryController =
        TextEditingController(text: userList[index].salary.toString());

    SharedPreferences prefs = await SharedPreferences.getInstance();

    User? updatedUser = await showDialog<User>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit User'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              SizedBox(height: 8.0), // Add spacing between fields
              TextField(
                controller: salaryController,
                decoration: InputDecoration(labelText: 'Salary'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String name = nameController.text;
                int salary = int.parse(salaryController.text);

                // Save updated user data to SharedPreferences
                prefs.setString('user_name_$index', name);
                prefs.setInt('user_salary_$index', salary);

                Navigator.of(context).pop(User(name: name, salary: salary));
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );

    if (updatedUser != null) {
      setState(() {
        userList[index] = updatedUser;
      });
    }
  }
}

class UserCard extends StatelessWidget {
  final User user;
  final VoidCallback onEditPressed;

  UserCard({required this.user, required this.onEditPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CalendarPage(userName: user.name, salary: user.salary)),
        );
      },
      child: Card(
        elevation: 4.0,
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(16.0),
          title: Text(
            user.name,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            'Salary: ₹${user.salary}',
            style: TextStyle(
              fontSize: 16.0,
              fontStyle: FontStyle.italic,
            ),
          ),
          leading: CircleAvatar(
            backgroundColor: Colors.indigo,
            child: Text(
              user.name.substring(0, 1),
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: onEditPressed,
          ),
        ),
      ),
    );
  }
}

class User {
  final String name;
  final int salary;

  User({required this.name, required this.salary});
}
