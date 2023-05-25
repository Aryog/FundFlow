import '../models/money_model.dart';

List<money> getter() {
  money moneyData = money();
  money moneyData1 = money();
  money moneyData2 = money();
  money moneyData3 = money();
  // can be of two types Income and expense
  moneyData.type = "Income";
  moneyData.amount = 500;
  moneyData.category = "Salary";
  moneyData.account = "Card";
  moneyData.remarks = "Hello";
  moneyData.date = DateTime(2023, 5, 25);
  moneyData1.type = "Expense";
  moneyData1.amount = 400;
  moneyData1.category = "Attire";
  moneyData1.account = "Cash";
  moneyData1.remarks = "Hello";
  moneyData2.type = "Income";
  moneyData2.amount = 400;
  moneyData2.category = "Cash";
  moneyData2.account = "Accounts";
  moneyData2.remarks = "World";
  moneyData2.date = DateTime(2023, 5, 25);
  moneyData3.type = "Income";
  moneyData3.amount = 400;
  moneyData3.category = "Bonus";
  moneyData3.account = "Card";
  moneyData3.remarks = "haha";
  moneyData3.date = DateTime(2023, 5, 25);
  return [moneyData, moneyData1, moneyData2, moneyData3];
}
