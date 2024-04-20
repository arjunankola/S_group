// import 'package:flutter/material.dart';
// import 'received_products_table.dart'; // Import the ReceivedProductsTable widget
// import 'GenerateBill.dart';

// class BillsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Bill Page'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           // Placeholder for Inventory page
//         ],
//       ),
//       floatingActionButton: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Center(
//             child: FloatingActionButton.extended(
//               onPressed: () {
//                 // Navigate to ReceivedProductsTable page
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => ReceivedProductsTable()),
//                 );
//               },
//               icon: Icon(Icons.receipt, color: Colors.white), // Set icon color to white
//               label: Text('Received Products', style: TextStyle(color: Colors.white)), // Set text color to white
//               tooltip: 'Track received products',
//               backgroundColor: Color(0xFF274060), // Set background color
//             ),
//           ),
//           SizedBox(height: 16),
//           Center(
//             child: FloatingActionButton.extended(
//               onPressed: () {
//                 // Navigate to GenerateBill page
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => GenerateBill()),
//                 );
//               },
//               icon: Icon(Icons.list_alt, color: Colors.white), // Set icon color to white
//               label: Text('Generate Bills', style: TextStyle(color: Colors.white)), // Set text color to white
//               tooltip: 'Generate pending bills',
//               backgroundColor: Color(0xFF274060), // Set background color
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'received_products_table.dart'; // Import the ReceivedProductsTable widget
import 'GenerateBill.dart';

class BillsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bill Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Placeholder for Inventory page
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: FloatingActionButton.extended(
              onPressed: () {
                // Navigate to ReceivedProductsTable page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReceivedProductsTable()),
                );
              },
              icon: Icon(Icons.receipt, color: Colors.white), // Set icon color to white
              label: Text('Received Products', style: TextStyle(color: Colors.white)), // Set text color to white
              tooltip: 'Track received products',
              backgroundColor: Color(0xFF274060), // Set background color
            ),
          ),
          FloatingActionButton.extended(
            onPressed: () {
              // Navigate to GenerateBill page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GenerateBill()),
              );
            },
            icon: Icon(Icons.list_alt, color: Colors.white), // Set icon color to white
            label: Text('Generate Bills', style: TextStyle(color: Colors.white)), // Set text color to white
            tooltip: 'Generate pending bills',
            backgroundColor: Color(0xFF274060), // Set background color
          ),
        ],
      ),
    );
  }
}
