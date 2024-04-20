// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class ReceivedProductsTable extends StatefulWidget {
//   @override
//   _ReceivedProductsTableState createState() => _ReceivedProductsTableState();
// }

// class _ReceivedProductsTableState extends State<ReceivedProductsTable> {
//   final _formKey = GlobalKey<FormState>();

//   // Variables to store form input values
//   String _date = '';
//   String _companyName = '';
//   String _productName = '';
//   double _productWeight = 0;
//   double _productPricePerKg = 0;

//   List<Map<String, dynamic>> _tableData = [];
// @override
//   void initState() {
//     super.initState();
//     _fetchData(); // Fetch data when the widget initializes
//   }

//   Future<void> _fetchData() async {
//     final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('received_products').get();
//     final List<Map<String, dynamic>> data = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
//     setState(() {
//       _tableData = data;

//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xFF274060),
//         title: Text(
//           'Received Product',
//           style: TextStyle(
//               fontSize: 20,
//               color: Colors.white), // Adjust the font size as needed
//         ),
//       ),
//       body: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               DataTable(
//                 columns: [
//                   DataColumn(label: Text('Date')),
//                   DataColumn(label: Text('Company Name')),
//                   DataColumn(label: Text('Product Name')),
//                   DataColumn(label: Text('Product Weight (kg)')),
//                   DataColumn(label: Text('Product Price (per kg)')),
//                   DataColumn(label: Text('Total Price')),
//                 ],
//                 rows: _tableData
//                     .map((data) => DataRow(cells: [
//                           DataCell(Text(data['date'])),
//                           DataCell(Text(data['companyName'])),
//                           DataCell(Text(data['productName'])),
//                           DataCell(Text(data['productWeight'].toString())),
//                           DataCell(Text(data['productPricePerKg'].toString())),
//                           DataCell(Text((data['productWeight'] *
//                                   data['productPricePerKg'])
//                               .toString())),
//                         ]))
//                     .toList(),
//               ),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () {
//                   _showAddEntryDialog(context);
//                 },
//                 child: Text(
//                   'Add',
//                   style: TextStyle(
//                       fontSize: 20,
//                       color: Colors.white), // Adjust the font size as needed
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _showAddEntryDialog(BuildContext context) {
//     DateTime selectedDate = DateTime.now();

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Add New Entry'),
//           content: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextButton(
//                   onPressed: () async {
//                     final DateTime? pickedDate = await showDatePicker(
//                       context: context,
//                       initialDate: selectedDate,
//                       firstDate: DateTime(2000),
//                       lastDate: DateTime(2101),
//                     );
//                     if (pickedDate != null && pickedDate != selectedDate)
//                       setState(() {
//                         selectedDate = pickedDate;
//                         _date =
//                             "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
//                       });
//                   },
//                   child: Text('Select Date'),
//                 ),
//                 TextFormField(
//                   decoration: InputDecoration(labelText: 'Company Name'),
//                   onChanged: (value) {
//                     setState(() {
//                       _companyName = value;
//                     });
//                   },
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter a company name';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   decoration: InputDecoration(labelText: 'Product Name'),
//                   onChanged: (value) {
//                     setState(() {
//                       _productName = value;
//                     });
//                   },
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter a product name';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   decoration: InputDecoration(labelText: 'Product Weight (kg)'),
//                   keyboardType: TextInputType.number,
//                   onChanged: (value) {
//                     setState(() {
//                       _productWeight = double.tryParse(value) ?? 0;
//                     });
//                   },
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter product weight';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   decoration:
//                       InputDecoration(labelText: 'Product Price (per kg)'),
//                   keyboardType: TextInputType.number,
//                   onChanged: (value) {
//                     setState(() {
//                       _productPricePerKg = double.tryParse(value) ?? 0;
//                     });
//                   },
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter product price per kg';
//                     }
//                     return null;
//                   },
//                 ),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 if (_formKey.currentState!.validate()) {
//                   _tableData.add({
//                     'date': _date,
//                     'companyName': _companyName,
//                     'productName': _productName,
//                     'productWeight': _productWeight,
//                     'productPricePerKg': _productPricePerKg,
//                   });
//                   await FirebaseFirestore.instance
//                       .collection('received_products')
//                       .add({
//                     'date': _date,
//                     'companyName': _companyName,
//                     'productName': _productName,
//                     'productWeight': _productWeight,
//                     'productPricePerKg': _productPricePerKg,
//                     'totalPrice': _productWeight *
//                         _productPricePerKg, // Calculate total price
//                   });

//                   setState(() {});
//                   Navigator.pop(context);
//                 }
//               },
//               child: Text('Add'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReceivedProductsTable extends StatefulWidget {
  @override
  _ReceivedProductsTableState createState() => _ReceivedProductsTableState();
}

class _ReceivedProductsTableState extends State<ReceivedProductsTable> {
  final _formKey = GlobalKey<FormState>();

  // Variables to store form input values
  String _date = '';
  String _companyName = '';
  String _productName = '';
  double _productWeight = 0;
  double _productPricePerKg = 0;

  List<Map<String, dynamic>> _tableData = [];

  @override
  void initState() {
    super.initState();
    _fetchData(); // Fetch data when the widget initializes
  }

  Future<void> _fetchData() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('received_products').get();
    final List<Map<String, dynamic>> data =
        snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    setState(() {
      _tableData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF274060),
        title: Text(
          'Received Product',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Company Name')),
                  DataColumn(label: Text('Product Name')),
                  DataColumn(label: Text('Product Weight (kg)')),
                  DataColumn(label: Text('Product Price (per kg)')),
                  DataColumn(label: Text('Total Price')),
                ],
                rows: _tableData.map((data) {
                  return DataRow(cells: [
                    DataCell(Text(data['date'])),
                    DataCell(Text(data['companyName'])),
                    DataCell(Text(data['productName'])),
                    DataCell(Text(data['productWeight'].toString())),
                    DataCell(Text(data['productPricePerKg'].toString())),
                    DataCell(Text(
                        (data['productWeight'] * data['productPricePerKg'])
                            .toString())),
                  ]);
                }).toList(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _showAddEntryDialog(context);
              },
                style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF274060),
                foregroundColor: Colors.white,
              ),
              child: Text(
                'Add',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddEntryDialog(BuildContext context) {
    DateTime selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Entry',style: TextStyle(color: Color(0xFF274060)),),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null && pickedDate != selectedDate)
                        setState(() {
                          selectedDate = pickedDate;
                          _date =
                              "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                        });
                    },
                    child: Text('Select Date'),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Company Name',focusColor: Color(0xFF274060)),
                    onChanged: (value) {
                      setState(() {
                        _companyName = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a company name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Product Name',focusColor: Color(0xFF274060)),
                    onChanged: (value) {
                      setState(() {
                        _productName = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a product name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration:
                        InputDecoration(labelText: 'Product Weight (kg)',focusColor: Color(0xFF274060)),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        _productWeight = double.tryParse(value) ?? 0;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter product weight';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration:
                        InputDecoration(labelText: 'Product Price (per kg)',focusColor: Color(0xFF274060),),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        _productPricePerKg = double.tryParse(value) ?? 0;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter product price per kg';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF274060)),foregroundColor: MaterialStateProperty.all<Color>(Colors.white)),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _tableData.add({
                    'date': _date,
                    'companyName': _companyName,
                    'productName': _productName,
                    'productWeight': _productWeight,
                    'productPricePerKg': _productPricePerKg,
                  });
                  await FirebaseFirestore.instance
                      .collection('received_products')
                      .add({
                    'date': _date,
                    'companyName': _companyName,
                    'productName': _productName,
                    'productWeight': _productWeight,
                    'productPricePerKg': _productPricePerKg,
                    'totalPrice': _productWeight *
                        _productPricePerKg, // Calculate total price
                  });

                  setState(() {});
                  Navigator.pop(context);
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
}
