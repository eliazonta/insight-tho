import 'package:gsheets/gsheets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class GoogleSheetsApi {
  Future <void> loadDotEnv() async{
    await dotenv.load(fileName: '/.env');
  }
  // create credentials
  static final _credentials = dotenv.env['CREDENTIALS'] ?? "SECRET_CREDENTIALS";
  
  // dotenv.env['SPREADSHEET_ID'] ?? "YOUR_SECRET_CREDENTIALS";

  // set up & connect to the spreadsheet
  static final _spreadsheetId = dotenv.env['SPREADSHEET_ID'] ?? "YOUR_SECRET_CREDENTIALS";
  // dotenv.env['CREDENTIALS'] ?? 'YOUR_SPREADSHEET_ID';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _worksheet;

  // some variables to keep track of..
  static int numberOfTransactions = 0;
  static List<List<dynamic>> currentTransactions = [];
  static bool loading = true;

  
  // initialise the spreadsheet!
  Future init() async {
    final ss = await _gsheets.spreadsheet(_spreadsheetId);
    _worksheet = ss.worksheetByTitle('WS1');
    countRows();
  }

  // count the number of notes
  static Future countRows() async {
    while ((await _worksheet!.values
            .value(column: 1, row: numberOfTransactions + 1)) !=
        '') {
      numberOfTransactions++;
    }
    // now we know how many notes to load, now let's load them!
    loadTransactions();
  }

  // load existing notes from the spreadsheet
  static Future loadTransactions() async {
    if (_worksheet == null) return;

    for (int i = 1; i < numberOfTransactions; i++) {
      final String transactionName =
          await _worksheet!.values.value(column: 1, row: i + 1);
      final String transactionAmount =
          await _worksheet!.values.value(column: 2, row: i + 1);
      final String transactionType =
          await _worksheet!.values.value(column: 3, row: i + 1);
      final String transactionTime = 
          await _worksheet!.values.value(column: 4, row: i + 1);

      if (currentTransactions.length < numberOfTransactions) {
        currentTransactions.add([
          transactionName,
          transactionAmount,
          transactionType,
          transactionTime,
        ]);
      }
    }
    // print(currentTransactions); // debug
    // this will stop the circular loading indicator
    loading = false;
  }
  // insert header 
  // static Future insertHeader() async {
  //   if (_worksheet == null) return;
  //   await _worksheet!.values.appendRow([
  //     "Insight Tho",
  //   ]);
  //   await _worksheet!.values.appendRow([
  //     "Subject",
  //     "Amount",
  //     "Type",
  //   ]);
  // }
  // insert a new transaction
  static Future insert(String name, String amount, bool isIncome) async {
    if (_worksheet == null) return;
    numberOfTransactions++;
    currentTransactions.add([
      name,
      amount,
      isIncome == true ? 'income' : 'expense',
    ]);
    await _worksheet!.values.appendRow([
      name,
      amount,
      isIncome == true ? 'income' : 'expense',
    ]);
  }

  // CALCULATE THE TOTAL INCOME
  static double calculateIncome() {
    double totalIncome = 0;
    for (int i = 0; i < currentTransactions.length; i++) {
      if (currentTransactions[i][2] == 'income') {
        totalIncome += double.parse(currentTransactions[i][1]);
      }
    }
    return totalIncome;
  }

  // CALCULATE THE TOTAL EXPENSE
  static double calculateExpense() {
    double totalExpense = 0;
    for (int i = 0; i < currentTransactions.length; i++) {
      if (currentTransactions[i][2] == 'expense') {
        totalExpense += double.parse(currentTransactions[i][1]);
      }
    }
    return totalExpense;
  }
}
