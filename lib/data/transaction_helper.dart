// import 'package:flutter/material.dart';
// import 'package:insightho/api/gsheet_api.dart';

//  // collect user input
//   final _textcontrollerAMOUNT = TextEditingController();
//   final _textcontrollerITEM = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool _isIncome = false;

//   // enter the new transaction into the spreadsheet
//   void _enterTransaction() {
//     GoogleSheetsApi.insert(
//       _textcontrollerITEM.text,
//       _textcontrollerAMOUNT.text,
//       _isIncome,
//     );
//     setState(() {});
//   }
// // new transaction
// void _newTransaction() {
//     showDialog(
//         barrierDismissible: false,
//         context: context,
//         builder: (BuildContext context) {
//           return StatefulBuilder(
//             builder: (BuildContext context, setState) {
//               return AlertDialog(
//                 title: const Text('N E W  T R A N S A C T I O N'),
//                 content: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           const Text('Expense'),
//                           Switch(
//                             value: _isIncome,
//                             onChanged: (newValue) {
//                               setState(() {
//                                 _isIncome = newValue;
//                               });
//                             },
//                           ),
//                           const Text('Income'),
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Form(
//                               key: _formKey,
//                               child: TextFormField(
//                                 decoration: const InputDecoration(
//                                   border: OutlineInputBorder(),
//                                   hintText: 'Amount?',
//                                 ),
//                                 validator: (text) {
//                                   if (text == null || text.isEmpty) {
//                                     return 'Enter an amount';
//                                   }
//                                   return null;
//                                 },
//                                 controller: _textcontrollerAMOUNT,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: TextField(
//                               decoration: const InputDecoration(
//                                 border: OutlineInputBorder(),
//                                 hintText: 'For what?',
//                               ),
//                               controller: _textcontrollerITEM,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 actions: <Widget>[
//                   Center(
//                     child: 
//                     Row(
//                       children: [
//                         MaterialButton(
//                           color: Colors.grey[600],
//                           child:
//                               const Text('Cancel', style: TextStyle(color: Colors.white)),
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                         ),
//                         MaterialButton(
//                           color: Colors.grey[600],
//                           child: const Text('Enter', style: TextStyle(color: Colors.white)),
//                           onPressed: () {
//                             if (_formKey.currentState!.validate()) {
//                               _enterTransaction();
//                               Navigator.of(context).pop();
//                             }
//                           },
//                         ),
//                       ],
//                     ),
//                   ),  
//                 ],
//               );
//             },
//           );
//         });
//   }