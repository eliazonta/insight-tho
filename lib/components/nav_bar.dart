import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insightho/api/gsheet_api.dart';
import 'package:insightho/components/plus_btn.dart';
import 'package:insightho/pages/home.dart';
import 'package:insightho/pages/profile.dart';
import 'package:insightho/pages/stats.dart';

class Nav extends StatefulWidget {
  const Nav({Key? key}) : super(key: key);

  @override
  State<Nav> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Nav> {
  final PageController pageController = PageController(initialPage: 0);
  late int _selectedIndex = 0;

// collect user input
  final _textcontrollerAMOUNT = TextEditingController();
  final _textcontrollerITEM = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isIncome = false;

  // enter the new transaction into the spreadsheet
  void _enterTransaction() {
    GoogleSheetsApi.insert(
      _textcontrollerITEM.text,
      _textcontrollerAMOUNT.text,
      _isIncome,
    );
    setState(() {});
  }

  // new transaction
  void _newTransaction() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
              return AlertDialog(
                backgroundColor: Colors.black,
                title: const Text(
                    style: TextStyle(color: Colors.orange, fontSize: 20),
                    'N E W  T R A N S A C T I O N'),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            'Expense',
                            style: TextStyle(color: Colors.orange),
                          ),
                          CupertinoSwitch(
                            activeColor: Colors.green,
                            trackColor: Colors.red,
                            value: _isIncome,
                            onChanged: (newValue) {
                              setState(() {
                                _isIncome = newValue;
                              });
                            },
                          ),
                          const Text(
                            'Income',
                            style: TextStyle(color: Colors.orange),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Form(
                              key: _formKey,
                              child: CupertinoTextField(
                                controller: _textcontrollerAMOUNT,
                                autocorrect: false,
                                placeholder: "Amount?",
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CupertinoTextField(
                              controller: _textcontrollerITEM,
                              autocorrect: false,
                              placeholder: "For what?",
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                          width: 200,
                          child: CupertinoButton(
                            color: Colors.white,
                            child: const Text('Enter',
                                style: TextStyle(color: Colors.green)),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _enterTransaction();
                                Navigator.of(context).pop();
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 200,
                          height: 50,
                          child: CupertinoButton(
                            color: Colors.white,
                            child: const Text('Cancel',
                                style: TextStyle(color: Colors.red)),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        });
  }

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
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Insight Tho'),
      //   centerTitle: true,
      // ),
      extendBody: true,
      body: SafeArea(
        child: PageView(
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          controller: pageController,
          children: const <Widget>[
            Center(
              child: HomePage(),
            ),
            Center(
              child: Search(),
            ),
            Center(
              child: Stats(),
            ),
            Center(
              child: Profile(),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: PlusButton(function: _newTransaction),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black87,
        shape: const CircularNotchedRectangle(),
        notchMargin: 7.0,
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: kBottomNavigationBarHeight + 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              IconButton(
                icon: const Icon(CupertinoIcons.home, color: Colors.orange),
                onPressed: () => pageController.jumpToPage(0),
              ),
              IconButton(
                  icon: const Icon(CupertinoIcons.chart_bar_alt_fill),
                  color: Colors.orange,
                  onPressed: () => pageController.jumpToPage(1)),
              IconButton(
                icon: const Icon(CupertinoIcons.money_dollar),
                color: Colors.orange,
                onPressed: () => pageController.jumpToPage(2),
              ),
              IconButton(
                icon: const Icon(CupertinoIcons.profile_circled),
                color: Colors.orange,
                onPressed: () => pageController.jumpToPage(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Screens for the different bottom navigation items

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('Save money');
  }
}
