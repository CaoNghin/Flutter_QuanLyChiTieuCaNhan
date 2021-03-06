import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:daily_spending/models/transaction.dart';
import 'package:daily_spending/constants/categories.dart';

class NewTransaction extends StatefulWidget {
  static const routeName = '/new-transaction';
  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final inputTitleController = TextEditingController();
  final inputAmountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  Transactions transactions;
  String dropdownValue = 'Khoản chi khác';

  void chooseDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    transactions = Provider.of<Transactions>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Thêm chi tiêu mới",
          style: Theme.of(context).appBarTheme.textTheme.headline1,
        ),
        backgroundColor: Colors.white10,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            right: 20,
            left: 20,
            top: 30,
            bottom: (MediaQuery.of(context).viewInsets.bottom) + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: "Tên chi tiêu"),
                //onChanged: (value) => inputTitle = value,
                controller: inputTitleController,
              ),
              SizedBox(height: 10),
              TextField(
                decoration: const InputDecoration(
                  labelText: "Số tiền (VNĐ)",
                ),
                //onChanged: (value) => inputAmount = value,
                controller: inputAmountController,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              dropDownToSelectMonth(context),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    onTap: () => chooseDate(),
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        "Chọn ngày",
                        style: TextStyle(),
                      ),
                    ),
                  ),
                  Text(
                    DateFormat.yMMMd().format(_selectedDate),
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              RaisedButton(
                child: const Text("Thêm"),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  if (inputTitleController.text.isNotEmpty &&
                      (int.parse(inputAmountController.text)) >= 0 &&
                      _selectedDate != null) {
                    final enteredTitle = inputTitleController.text;
                    final enteredAmount = int.parse(inputAmountController.text);

                    transactions.addTransactions(
                      Transaction(
                        id: DateTime.now().toString(),
                        title: enteredTitle,
                        amount: enteredAmount,
                        date: _selectedDate,
                        category: dropdownValue,
                      ),
                    );
                    //Navigator.of(context).pop();
                    inputTitleController.clear();
                    inputAmountController.clear();
                    setState(() {
                      // _selectedDate = DateTime.now();
                      dropdownValue = 'Khoản chi khác';
                    });
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Theme.of(context).primaryColorLight,
                        content: Text(
                          "Đã thêm dữ liệu chi tiêu thành công!",
                          style: Theme.of(context).textTheme.headline1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Theme.of(context).errorColor,
                        content: Text(
                          "Bạn phải điền đầy đủ các thông tin!",
                          style: Theme.of(context).textTheme.headline1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dropDownToSelectMonth(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Loại chi tiêu:',
        ),
        DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(
            Icons.expand_more,
          ),
          elevation: 16,
          style: TextStyle(color: Theme.of(context).primaryColorDark),
          underline: Container(
            height: 2,
            color: Theme.of(context).primaryColor,
          ),
          onChanged: (String newValue) {
            setState(() {
              dropdownValue = newValue;
            });
          },
          items: categories.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}
