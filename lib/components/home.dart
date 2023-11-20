// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:insightho/api/gsheet_api.dart';
// import 'package:insightho/components/loading.dart';
// import 'package:insightho/components/top_card.dart';
// import 'transaction.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }
// // 
// class _HomePageState extends State<HomePage> {
//   // collect user input
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

//   // new transaction
//   void _newTransaction() {
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

//   // wait for the data to be fetched from google sheets
//   bool timerHasStarted = false;
//   void startLoading() {
//     timerHasStarted = true;
//     Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (GoogleSheetsApi.loading == false) {
//         setState(() {});
//         timer.cancel();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // start loading until the data arrives
//     if (GoogleSheetsApi.loading == true && timerHasStarted == false) {
//       startLoading();
//     }

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.all(25.0),
//         child: Column(
//           children: [
//             const SizedBox(
//               height: 30,
//             ),
//             TopCard(
//               balance: (GoogleSheetsApi.calculateIncome() -
//                       GoogleSheetsApi.calculateExpense())
//                   .toString(),
//               income: GoogleSheetsApi.calculateIncome().toString(),
//               expense: GoogleSheetsApi.calculateExpense().toString(),
//             ),
//             Expanded(
//               child: Center(
//                 child: Column(
//                   children: [
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     Expanded(
//                       child: GoogleSheetsApi.loading == true
//                           ? const LoadingCircle()
//                           : ListView.builder(
//                               itemCount:
//                                   GoogleSheetsApi.currentTransactions.length,
//                               itemBuilder: (context, index) {
//                                 return NewTransaction(
//                                   transactionName: GoogleSheetsApi
//                                       .currentTransactions[index][0],
//                                   amount: GoogleSheetsApi
//                                       .currentTransactions[index][1],
//                                   type: GoogleSheetsApi
//                                       .currentTransactions[index][2],
//                                 );
//                               }),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             // PlusButton(
//             //   function: _newTransaction,
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }
