import 'package:gsheets/gsheets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class GoogleSheetsApi {
  Future <void> loadDotEnv() async{
    await dotenv.load(fileName: '/.env');
  }
  // create credentials
  static const _credentials =r'''
{
  "type": "service_account",
  "project_id": "mmoney-405120",
  "private_key_id": "6ee426e88d3b52710fe3597388e17822726cf220",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDhO5araAv00AGh\niJP5b3H7cuMeaPSq2/oCulj8uF66QL1gdlWgB1436wwVTyXU2PyOQvH47tT7CyKK\nPx2/q6+XmaNKAd9FGaBwE9BVkrIz1KmZ4pfY4pkexWWWWf4x2Th7j/g+1pr0tMSF\nqAFAHzgyT6pGaLeMoCQtczDlXgZeWOJ+Z8kw61MzLF46P8QbIOSEg/MiedjZ9Tti\nCNKzBMlhzCHC+cYQIIGIOxWKDXdClkx7tKC8f8VVGKiskVgFzUU0C1G14C+qR7lI\no6axn/oKknSVuTFP09egVI7r8K733xcmQtEuzTkCh9U7fkcwc+cs6pQN1ToCekq2\nrNJcWbXbAgMBAAECggEAAep9WiDs9Ryt3t9oDtelWxO7nd8bsbZkVpCaQDAbUi9J\nzR/Ek7NsWEJuHGJLepeL8nPcVhdGBYqvNQjbam199Wavrmn8qbxRkpKAk7HHRUya\nUr5MN2KaFdptBk3mrSrhYZ+0Z2hw8gL1pwNqW07IrhjiZG3wncgg9qgDsvfNSxEn\naC8lZqblcw6akgrJAQwZ1zXLunmji2NSqHU45fKPkB2JRZ4PzOzalt1JSbC3Islh\nyzKS8EnWGu2+V+1Ydupa99/I3yasxdB2HCu2BB8GUWW/RSB0JeR3n+XbEBrQAka8\nmYLTRlRb0u+rPk3d0mfTLB/EMBW+Pw0FD8hZ0bA41QKBgQD/pR8966Wy7QkBiR7/\nlXGTSsCBh2F6XcHyWrCTCEETqHEE8XMwmGoCt4ODgJ3rGq4zVUqMeoXd8BaP4izP\nip2mIwWHj/X7vik5qV+lEqvcG+hbqJvD5gKy1GwVHsyXhPPgXscgjikBqOFHCuKC\nIPbPnrE7WqCBe/t53xYZw03aBQKBgQDhi6fJlX6E+TLqg/a69MLiatWcL7R8UgP3\nn2R7vkyLZby+J3idvTWvY7dFXMcagTYfxZXemGhjfAmMbcdPMRvt8Tjgcs7qdNni\nSbVXVmHkVt8Opvw9RMyLQijH4dyiiySrh7CYcuP5OUfhFieJPZHzErqyFNDsgj2P\nCekZeDH2XwKBgQDs5dwUqlkLfKJ63NFv8NGlt4C6x3SqS1XduvKj3eNITzAkb4ba\nAnNCf0KMytQMONYy1ZfWo/eHWePeg64YyRAcE5odLGe7WFWljHIIa0v9FZN11MI7\nf9sCUtyxma/nvRmt0sZeQb54PkI8bjbGdbuhXCJKqUnRk83O+s7lItny7QKBgQDY\npxcIi4KZ5uqi3RpfYgfmCGuieSytEvdeoIycVSMf8B1Kp420L/Fmxalhhop3ClFc\nWabpyIrVrWtaqoT+rBTBDqrs5zudeZtmRBleiMrF1TC02XCIxhKZXnbf8jTHKlOS\nNWhMOGiGmSBTtb1Klosg7AfMUjSSS1UoloOEBLIxjwKBgHL6ocdRRGzthA4KLc3M\nnQoc+qDOyNpid0ScW7RDeHZuZ+O8pPWRq422m/Kms85LcaJnq2QaWdtJgpkpFL2Q\natJbpHfAivTLQlzhctJSHlcv6ElTUF0+/OVLNQMn0O6a1vDAEC163qiHmteyazqe\n2E8WikWYoiThu80J2Pso+yg2\n-----END PRIVATE KEY-----\n",
  "client_email": "mmoney@mmoney-405120.iam.gserviceaccount.com",
  "client_id": "110581937430588399082",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/mmoney%40mmoney-405120.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
''';
  
  // dotenv.env['SPREADSHEET_ID'] ?? "YOUR_SECRET_CREDENTIALS";

  // set up & connect to the spreadsheet
  static const _spreadsheetId = "1XkAR0nlYIzqS9nh7ntWfM6JSXcYggVMhiKcLU5YsJ4I";
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
