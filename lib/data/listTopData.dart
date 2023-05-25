import '../models/money_model.dart';

List<money> getter_top() {
  money snap_food = money();
  money snap = money();

  // Data here
  snap_food.date = DateTime(2023, 5, 25);
  snap_food.category = "Food";
  snap_food.amount = 100;
  snap_food.type = "Expense";
  snap_food.account = "Cash";
  return [snap_food];
}
