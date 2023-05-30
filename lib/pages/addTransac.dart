import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fundflow/models/money_model.dart';
import 'package:fundflow/providers/money_provider.dart';
import 'package:fundflow/utils/app_layout.dart';
import 'package:fundflow/utils/app_styles.dart';
import 'package:fundflow/utils/app_utilities.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class AppAddScreen extends StatefulWidget {
  bool isFromHome;
  String? id;
  String? type;
  double? amount;
  String? category;
  String? account;
  String? remarks;
  DateTime? date;
  AppAddScreen(
      {super.key,
      this.id,
      this.type,
      this.amount,
      this.category,
      this.account,
      this.remarks,
      this.date,
      required this.isFromHome});

  @override
  State<AppAddScreen> createState() => _AppAddScreenState();
}

class _AppAddScreenState extends State<AppAddScreen> {
  DateTime date = DateTime.now();
  int activeIndex = 0;
  String? selectedItem;
  String? selectedMethod;
  final TextEditingController explain_C = TextEditingController();
  final TextEditingController amount_C = TextEditingController();
  FocusNode ex = FocusNode();
  FocusNode nu = FocusNode();
  bool isLoading = false;
  final List<String> _itemIn = [
    'Allowance',
    'Salary',
    'Cash',
    'Bonus',
    'Others'
  ];
  final List<String> _itemEx = [
    'Food',
    'Transport',
    'Household',
    'Health',
    'Education',
    'Attire',
    'Others'
  ];
  final List<String> _method = [
    'Card',
    'Accounts',
    'Cash',
  ];
  @override
  void dispose() {
    explain_C.dispose();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // Perform state updates or trigger rebuilds here
      setState(() {
        // Update state variables
        if (widget.isFromHome == false) {
          // Save the initial data based on the value of isFromHome
          if (widget.type == 'Income') {
            // Initial data for income
            activeIndex = 0;
          } else if (widget.type == 'Expense') {
            // Initial data for expense
            activeIndex = 1;
          }
          selectedItem = widget.category;
          selectedMethod = widget.account;
          amount_C.text = widget.amount.toString();
          explain_C.text = widget.remarks!;
          context.read<MoneyProvider>().updateAccount(selectedMethod!);
          context.read<MoneyProvider>().updateRemarks(explain_C.text);
          date = widget.date!;
        }
      });
    });
    super.initState();
    ex.addListener(() {
      setState(() {});
    });
    nu.addListener(() {
      setState(() {});
    });
  }

  void saveData() async {
    try {
      setState(() {
        isLoading = true;
      });
      print("clicked");
      String type = "Income";
      if (activeIndex == 0) {
        type = "Income";
      } else {
        type = "Expense";
      }

      print(selectedItem);
      print(selectedMethod);
      print(amount_C.text);
      print(explain_C.text);
      print(date);
      // TODO: Add the future function to add data
      if (selectedItem == null &&
          selectedItem!.isEmpty &&
          selectedMethod == null &&
          selectedMethod!.isEmpty &&
          amount_C.text.isEmpty) return;
      money data = await Utils.insertData(type, selectedItem!, selectedMethod!,
          double.tryParse(amount_C.text), explain_C.text, date);
      print(data);
      setState(() {
        selectedItem = null;
        selectedMethod = null;
        amount_C.clear();
        explain_C.clear;
        context.read<MoneyProvider>().resetStateAdd();
        isLoading = false;
      });
    } catch (e) {
      print("error occured is ${e}");
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget build(BuildContext context) {
    final stateAdd = context.watch<MoneyProvider>().stateAdd;
    explain_C.text = stateAdd.remarks!;
    explain_C.selection =
        TextSelection.collapsed(offset: explain_C.text.length);
    selectedMethod = stateAdd.account;
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: SafeArea(
          child: Stack(
        alignment: Alignment.center,
        children: [
          background_container(context),
          Positioned(
            top: 100,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppLayout.getHeight(20)),
                  color: Colors.white),
              height: AppLayout.getHeight(500),
              width: AppLayout.getWidth(340),
              child: Column(children: [
                Gap(AppLayout.getHeight(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          activeIndex = 0;
                          selectedItem = null;
                        });
                      },
                      child: Text(
                        "Income",
                        style: TextStyle(
                            color: activeIndex == 0
                                ? Colors.green.shade300
                                : Styles.primaryColor),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: activeIndex == 0
                            ? Colors.grey.shade300
                            : Styles.bgColor,
                        padding: EdgeInsets.symmetric(
                            horizontal: AppLayout.getHeight(50)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                AppLayout.getHeight(100))),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          activeIndex = 1;
                          selectedItem = null;
                        });
                      },
                      child: Text(
                        "Expense",
                        style: TextStyle(
                            color: activeIndex == 1
                                ? Colors.red.shade300
                                : Styles.primaryColor),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: activeIndex == 1
                            ? Colors.grey.shade300
                            : Styles.bgColor,
                        padding: EdgeInsets.symmetric(
                            horizontal: AppLayout.getHeight(50)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                AppLayout.getHeight(100))),
                      ),
                    )
                  ],
                ),
                const Divider(
                  thickness: sqrt1_2,
                ),
                activeIndex == 0
                    ? category(_itemIn, false)
                    : category(_itemEx, false),
                Gap(AppLayout.getHeight(10)),
                inputRemarks("Amount", true, context),
                Gap(AppLayout.getHeight(10)),
                category(_method, true),
                Gap(AppLayout.getHeight(10)),
                inputRemarks("Remarks", false, context),
                Gap(AppLayout.getHeight(20)),
                date_time(context),
                Gap(AppLayout.getHeight(20)),
                saveBtn()
              ]),
            ),
          )
        ],
      )),
    );
  }

  GestureDetector saveBtn() {
    return GestureDetector(
      onTap: () => saveData(),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Color(0xff368983)),
        width: 120,
        height: 50,
        child: isLoading
            ? Transform.scale(
                scale: 0.7,
                child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                "Save",
                style: Styles.headLineStyle3.copyWith(color: Colors.white),
              ),
      ),
    );
  }

  Container date_time(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppLayout.getHeight(10)),
        border: Border.all(width: 2, color: Color(0xffc5c5c5)),
      ),
      width: AppLayout.getHeight(300),
      child: TextButton(
        onPressed: () async {
          DateTime? newDate = await showDatePicker(
              context: context,
              initialDate: date,
              firstDate: DateTime(2000),
              lastDate: DateTime(2050));
          if (newDate == Null) return;
          setState(() {
            date = newDate!;
          });
        },
        child: Text(
          "Date: ${Utils.getMonth(date.month)} ${date.day},${date.year}",
          style: Styles.headLineStyle3.copyWith(
              fontWeight: FontWeight.normal, color: Styles.primaryColor),
        ),
      ),
    );
  }

  Padding inputRemarks(String str, bool isNumber, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        onChanged: (value) =>
            isNumber ? "" : context.read<MoneyProvider>().updateRemarks(value),
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        focusNode: isNumber ? nu : ex,
        controller: isNumber ? amount_C : explain_C,
        decoration: InputDecoration(
          prefixText: isNumber ? "\$  " : "",
          contentPadding: EdgeInsets.symmetric(
              horizontal: AppLayout.getHeight(15),
              vertical: AppLayout.getHeight(15)),
          labelText: str,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 2, color: Color(0xffc5c5c5))),
          labelStyle: TextStyle(fontSize: 17, color: Colors.grey.shade500),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 2, color: Styles.primaryColor)),
        ),
      ),
    );
  }

  Padding category(List<String> _item, bool isMethod) {
    return Padding(
      padding: EdgeInsets.all(AppLayout.getHeight(8)),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: AppLayout.getHeight(8)),
        width: AppLayout.getHeight(300),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2, color: Color(0xffc5c5c5))),
        child: DropdownButton<String>(
          value: isMethod ? selectedMethod : selectedItem,
          items: _item
              .map((e) => DropdownMenuItem(
                    child: Container(
                      child: Container(
                        child: Row(children: [
                          Visibility(
                            visible: e != 'Others',
                            child: Container(
                              width: 32,
                              child: Image.asset("assets/images/${e}.png"),
                            ),
                          ),
                          Gap(AppLayout.getHeight(10)),
                          Text(
                            e,
                            style: TextStyle(fontSize: 18),
                          )
                        ]),
                      ),
                    ),
                    value: e,
                  ))
              .toList(),
          selectedItemBuilder: (context) => _item
              .map((e) => Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(AppLayout.getHeight(5)),
                        width: 42,
                        child: Image.asset('assets/images/${e}.png'),
                      ),
                      Gap(AppLayout.getHeight(10)),
                      Text(e)
                    ],
                  ))
              .toList(),
          hint: Text(
            isMethod ? 'Method' : 'Category',
            style: TextStyle(color: Colors.grey),
          ),
          dropdownColor: Colors.white,
          isExpanded: true,
          underline: Container(),
          onChanged: (value) {
            setState(() {
              if (isMethod) {
                selectedMethod = value!;
                context.read<MoneyProvider>().updateAccount(value);
              } else {
                selectedItem = value!;
              }
            });
          },
        ),
      ),
    );
  }

  Column background_container(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(AppLayout.getHeight(8)),
          width: double.infinity,
          height: AppLayout.getHeight(240),
          decoration: BoxDecoration(
            color: Styles.secondaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(children: [
            Gap(AppLayout.getHeight(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                Text(
                  activeIndex == 0 ? "Income" : "Expense",
                  style: Styles.headLineStyle2.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
                Icon(
                  Icons.attach_file_outlined,
                  color: Colors.white,
                )
              ],
            )
          ]),
        )
      ],
    );
  }
}
