import 'package:insightho/components/expense_item.dart';
import 'package:insightho/data/datetime_helper.dart';

class ExpenseData{
  // list of expenses
  List<ExpenseItem> overallExpense = [];

  // get list 
  List<ExpenseItem> getOverallExpese()
  {
    return overallExpense;
  }

  // add expense
  void addNewExpense(ExpenseItem item)
  {
    overallExpense.add(item);
  }

  // remove expense
  void deleteExpese(ExpenseItem item)
  {
    overallExpense.remove(item);
  }

  // get weekday from DateTime obj 
  String getDay(DateTime dateTime)
  {
    switch (dateTime.weekday) {
      case 1: return 'Mon';
      case 2: return 'Tue';
      case 3: return 'Wed';
      case 4: return 'Thu';
      case 5: return 'Fri';
      case 6: return 'Sat';
      case 7: return 'Sun';        
      default: return '';
    }
  }

  DateTime startOfTheWeekDate()
  {
    DateTime? startOfTheWeek;

    // today
    DateTime today = DateTime.now();

    for (int i = 0; i < 7; ++i) 
    {
      if(getDay(today.subtract(Duration(days: i))) == 'Sun') 
      {
        startOfTheWeek = today.subtract(Duration(days: i));
      }  
    }
    return startOfTheWeek!;
  }
  /*
    Overall expese list =
    [
      [food, 2023/10/22, $10]
      [a, 2023/10/22, $10]
      [b, 2023/10/26, $10]
      [c, 2023/10/27, $10]
    ]

    -> 

    dailyyExpenseSummary = 
    [
      [20231022, $20]
      [20231022, $10]
      [20231026, $10]
      [20231027, $10]
    ]
   */

  Map<String, double> calculateDailyExpenseSummary()
  {
    Map<String, double> dailyExpenseSummary = {

    };

    for (var expense in overallExpense) {
      String date = dateTimeConverter(expense.dateTime);
      double amount = double.parse(expense.amount); 
      if(dailyExpenseSummary.containsKey(date))
      {
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      }else 
      {
        dailyExpenseSummary.addAll({date : amount});
      }
    }
    return dailyExpenseSummary;
  }
}

