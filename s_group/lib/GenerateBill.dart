// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class SearchBar extends StatefulWidget {
//   @override
//   _SearchBarState createState() => _SearchBarState();
// }

// class _SearchBarState extends State<SearchBar> {
//   String query = '';
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   List<DocumentSnapshot> searchResults = [];

//   void searchFirestore(String searchText) {
//     _firestore
//         .collection('received_products')
//         .where('companyName', isEqualTo: searchText)
//         .get()
//         .then((QuerySnapshot snapshot) {
//       setState(() {
//         searchResults = snapshot.docs;
//         // Group search results by company name
//         Map<String, List<DocumentSnapshot>> groupedResults = {};
//         for (var doc in searchResults) {
//           String companyName = doc['companyName'];
//           if (!groupedResults.containsKey(companyName)) {
//             groupedResults[companyName] = [];
//           }
//           groupedResults[companyName]!.add(doc);
//         }
//         // Filter the grouped results to get the latest date for each company
//         List<DocumentSnapshot> filteredResults = [];
//         groupedResults.forEach((companyName, docs) {
//           // Sort the documents by date in descending order
//           docs.sort((a, b) => b['date'].compareTo(a['date']));
//           // Add the document with the latest date to the filtered results
//           filteredResults.add(docs.first);
//         });
//         searchResults = filteredResults;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         Container(
//           padding: const EdgeInsets.all(16),
//           child: TextField(
//             onChanged: (value) {
//               searchFirestore(value);
//             },
//             decoration: const InputDecoration(
//               labelText: 'Company Name',
//               border: OutlineInputBorder(),
//               prefixIcon: Icon(Icons.search),
//             ),
//           ),
//         ),
//         DataTable(
//           columns: const <DataColumn>[
//             DataColumn(label: Text('companyName')),
//             DataColumn(label: Text('date')),
//             DataColumn(label: Text('productWeight')),
//             DataColumn(label: Text('productName')),
//             DataColumn(label: Text('productPricePerKg')),
//           ],
//           rows: searchResults.map((doc) {
//             final data = doc.data() as Map<String, dynamic>;
//             return DataRow(cells: [
//               DataCell(Text(data['companyName'].toString())),
//               DataCell(Text(data['date'].toString())),
//               DataCell(Text(data['productWeight'].toString())),
//               DataCell(Text(data['productName'].toString())),
//               DataCell(Text(data['productPricePerKg'].toString())),
//               // Add more DataCell widgets for additional fields
//             ]);
//           }).toList(),
//         ),
//       ],
//     );
//   }
// }
// class SearchBar extends StatefulWidget {
//   @override
//   _SearchBarState createState() => _SearchBarState();
// }

// class _SearchBarState extends State<SearchBar> {
//   String query = '';
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   List<DocumentSnapshot> searchResults = [];

// void searchFirestore(String searchText) {
//   _firestore
//       .collection('received_products')
//       .where('companyName', isEqualTo: searchText)
//       .get()
//       .then((QuerySnapshot snapshot) {
//     setState(() {
//       searchResults = snapshot.docs;
//       // Group search results by company name
//       Map<String, List<DocumentSnapshot>> groupedResults = {};
//       for (var doc in searchResults) {
//         String companyName = doc['companyName'];
//         if (!groupedResults.containsKey(companyName)) {
//           groupedResults[companyName] = [];
//         }
//         groupedResults[companyName]!.add(doc);
//       }
//       // Filter the grouped results to get the latest date for each company
//       List<DocumentSnapshot> filteredResults = [];
//       groupedResults.forEach((companyName, docs) {
//         // Sort the documents by date in descending order
//         docs.sort((a, b) => b['date'].compareTo(a['date']));
//         // Add the document with the latest date to the filtered results
//         filteredResults.add(docs.first);
//       });
//       searchResults = filteredResults;
//     });
//   });
// }

//   void searchFirestore(String searchText) {
//   _firestore
//       .collection('received_products')
//       .where('companyName', isEqualTo: searchText)
//       .get()
//       .then((QuerySnapshot snapshot) {
//     setState(() {
//       List<DocumentSnapshot> allResults = snapshot.docs;
//       // Group search results by company name
//       Map<String, List<DocumentSnapshot>> groupedResults = {};
//       for (var doc in allResults) {
//         String companyName = doc['companyName'];
//         if (!groupedResults.containsKey(companyName)) {
//           groupedResults[companyName] = [];
//         }
//         groupedResults[companyName]!.add(doc);
//       }
//       // Filter the grouped results to get the latest date for each company
//       List<DocumentSnapshot> filteredResults = [];
//       groupedResults.forEach((companyName, docs) {
//         // Sort the documents by date in descending order
//         docs.sort((a, b) => b['date'].compareTo(a['date']));
//         // Add the document with the latest date to the filtered results
//         filteredResults.add(docs.first);
//       });
//       searchResults = filteredResults;
//     });
//   });
// }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         Container(
//           padding: const EdgeInsets.all(16),
//           child: TextField(
//             onChanged: (value) {
//               searchFirestore(value);
//             },
//             decoration: const InputDecoration(
//               labelText: 'Company Name',
//               border: OutlineInputBorder(),
//               prefixIcon: Icon(Icons.search),
//             ),
//           ),
//         ),
//         Expanded(
//           child: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: DataTable(
//               columns: const <DataColumn>[
//                 DataColumn(label: Text('Company Name')),
//                 DataColumn(label: Text('Date')),
//                 DataColumn(label: Text('Product Weight')),
//                 DataColumn(label: Text('Product Name')),
//                 DataColumn(label: Text('Product Price Per Kg')),
//                 // Add more DataColumn widgets for additional fields
//               ],
//               rows: searchResults.map((doc) {
//                 final data = doc.data() as Map<String, dynamic>;
//                 return DataRow(cells: [
//                   DataCell(Text(data['companyName'].toString())),
//                   DataCell(Text(data['date'].toString())),
//                   DataCell(Text(data['productWeight'].toString())),
//                   DataCell(Text(data['productName'].toString())),
//                   DataCell(Text(data['productPricePerKg'].toString())),
//                   // Add more DataCell widgets for additional fields
//                 ]);
//               }).toList(),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class GenerateBill extends StatelessWidget {
//   GenerateBill() : super();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color.fromRGBO(39, 64, 96, 1),
//         title: const Text(
//           'Generate Bill',
//           style: TextStyle(
//               fontSize: 20,
//               color: Colors.white), // Adjust the font size as needed
//         ),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: SearchBar(), // Wrapped with Expanded
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:open_file/open_file.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Generate Bill',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GenerateBill(),
    );
  }
}

class GenerateBill extends StatelessWidget {
  GenerateBill() : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(39, 64, 96, 1),
        title: const Text(
          'Generate Bill',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchBar(), // Wrapped with Expanded
            ),
          ),
        ],
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  String query = '';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> searchResults = [];

  void searchFirestore(String searchText) {
    _firestore
        .collection('received_products')
        .where('companyName', isEqualTo: searchText)
        .get()
        .then((QuerySnapshot snapshot) {
      setState(() {
        List<DocumentSnapshot> allResults = snapshot.docs;
        // Group search results by company name
        Map<String, List<DocumentSnapshot>> groupedResults = {};
        for (var doc in allResults) {
          String companyName = doc['companyName'];
          if (!groupedResults.containsKey(companyName)) {
            groupedResults[companyName] = [];
          }
          groupedResults[companyName]!.add(doc);
        }
        // Filter the grouped results to get the latest date for each company
        List<DocumentSnapshot> filteredResults = [];
        groupedResults.forEach((companyName, docs) {
          // Sort the documents by date in descending order
          docs.sort((a, b) => b['date'].compareTo(a['date']));
          // Add the document with the latest date to the filtered results
          filteredResults.add(docs.first);
        });
        searchResults = filteredResults;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16),
          child: TextField(
            onChanged: (value) {
              searchFirestore(value);
            },
            decoration: const InputDecoration(
              labelText: 'Company Name',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const <DataColumn>[
                DataColumn(label: Text('Company Name')),
                DataColumn(label: Text('Date')),
                DataColumn(label: Text('Product Weight')),
                DataColumn(label: Text('Product Name')),
                DataColumn(label: Text('Product Price Per Kg')),
                // Add more DataColumn widgets for additional fields
              ],
              rows: searchResults.map((doc) {
                final data = doc.data() as Map<String, dynamic>;
                return DataRow(cells: [
                  DataCell(Text(data['companyName'].toString())),
                  DataCell(Text(data['date'].toString())),
                  DataCell(Text(data['productWeight'].toString())),
                  DataCell(Text(data['productName'].toString())),
                  DataCell(Text(data['productPricePerKg'].toString())),
                  // Add more DataCell widgets for additional fields
                ]);
              }).toList(),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            generatePDF();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF274060),
            foregroundColor: Colors.white,
          ),
          child: Text('Generate PDF'),
        ),
      ],
    );
  }

  Future<void> generatePDF() async {
    // Create a new PDF document
    PdfDocument document = PdfDocument();

    try {
      // Add a page to the document
      PdfPage page = document.pages.add();
      // Create a PDF layout format
      PdfLayoutResult? result = PdfTextElement(
        text:
            'Company Name: $query\nDate: ${DateFormat('yyyy-MM-dd').format(DateTime.now())}',
        font: PdfStandardFont(PdfFontFamily.helvetica, 20),
      ).draw(
        page: page,
        bounds: Rect.fromLTWH(0, 0, page.getClientSize().width, 100),
        format: PdfLayoutFormat(layoutType: PdfLayoutType.paginate),
      );

      // Calculate remaining height for table
      double remainingHeight =
          page.getClientSize().height - result!.bounds.bottom;
      // Define the table
      PdfGrid grid = PdfGrid();

      grid.columns.add(count: 3);
      final PdfGridRow headerRow = grid.headers.add(1)[0];

      headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
      headerRow.style.textBrush = PdfBrushes.white;

      // Add headers to the grid
      headerRow.cells[0].value = 'Company Name';
      headerRow.cells[1].value = 'Date';
      // Add data to the table
      for (var doc in searchResults) {
        final data = doc.data() as Map<String, dynamic>;
        grid.rows.add(<dynamic>[
          data['companyName'].toString(),
          data['date'].toString(),
          // Add more fields as needed
        ] as PdfGridRow?);
      }

      // Draw the table
      result = grid.draw(
        page: page,
        bounds: Rect.fromLTWH(0, result.bounds.bottom + 10,
            page.getClientSize().width, remainingHeight - 10),
      );
      // Save the document

      final Future<List<int>> bytes = document.save();
      document.dispose();
      await saveAndLaunchFile(bytes as List<int>, 'generated_pdf.pdf');
    } catch (e, stackTrace) {
      log('Error generating PDF: $e\n$stackTrace');
    }
  }

  Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
    try {
      final path = (await getExternalStorageDirectory())?.path;
      log(path!);
      final file = File('$path/$fileName');
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open('$path/$fileName');
    } catch (e) {
      log('Error saving and launching file: $e');
    }
  }
}
