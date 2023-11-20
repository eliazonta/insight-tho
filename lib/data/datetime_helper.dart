// DateTime to yyyymmdd

String dateTimeConverter(DateTime dt)
{
  String year = dt.year.toString();

  String month = dt.month.toString();
  if(month.length == 1) month = '0$month';

  String day = dt.day.toString();
  if(day.length == 1) day = '0$day';

  return year + month + day;
}