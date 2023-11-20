import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insightho/api/gsheet_api.dart';
import 'package:insightho/components/loading.dart';
import 'package:insightho/components/top_card.dart';
import 'package:insightho/components/transaction.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // wait for the data to be fetched from google sheets
  bool timerHasStarted = false;
  void startLoading() {
    timerHasStarted = true;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (GoogleSheetsApi.loading == false) {
        setState(() {});
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // start loading until the data arrives

    if (GoogleSheetsApi.loading == true && timerHasStarted == false) {
      startLoading();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            TopCard(
              balance: (GoogleSheetsApi.calculateIncome() -
                      GoogleSheetsApi.calculateExpense())
                  .toString(),
              income: GoogleSheetsApi.calculateIncome().toString(),
              expense: GoogleSheetsApi.calculateExpense().toString(),
            ),
            Expanded(
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: GoogleSheetsApi.loading == true
                          ? const LoadingCircle()
                          : ListView.builder(
                              reverse: true,
                              itemCount:
                                  GoogleSheetsApi.currentTransactions.length,
                              itemBuilder: (context, index) {
                                return NewTransaction(
                                  transactionName: GoogleSheetsApi
                                      .currentTransactions[index][0],
                                  amount: GoogleSheetsApi
                                      .currentTransactions[index][1],
                                  type: GoogleSheetsApi
                                      .currentTransactions[index][2],
                                );
                              }),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // PlusButton(
            //   function: _newTransaction,
            // ),
          ],
        ),
      ),
    );
  }
}
