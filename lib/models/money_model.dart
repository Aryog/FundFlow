import 'dart:convert';

class money {
  // maybe income expense to be checked while adding and the top tabs will be better
  String? type;
  double? amount;
  // category may be of the allowance,salary,cash,bonus,other if income
  // category may be of the food,transport,household,health,education,Attire,borrow,other
  String? category;
  // account may of only three types cash accounts and card
  String? account;
  String? remarks;
  DateTime? date;
  money(
      {this.type,
      this.amount,
      this.category,
      this.account,
      this.remarks,
      this.date});
  factory money.fromJson(Map<String, dynamic> json) {
    return money(
        account: json['account'],
        type: json['type'],
        category: json['category'],
        amount: (json['amount'] as num).toDouble(),
        remarks: json['remarks'],
        date: DateTime.parse(json['updatedAt']));
  }
}
