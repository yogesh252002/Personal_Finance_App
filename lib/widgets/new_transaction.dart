import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }

    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      // MainAxisAlignment :MainAxisAlignment,
      padding: EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10,
        bottom: MediaQuery.of(context).viewInsets.bottom + 30,
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            decoration: InputDecoration(labelText: "Title"),
            controller: _titleController,
            onSubmitted: (_) => submitData(),

            // onChanged: (val) {
            //    inputTitle =val ;
            // },
          ),
          TextField(
            decoration: InputDecoration(labelText: "Amount"),
            controller: _amountController,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => submitData(),
            // onChanged: (val) {
            //   inputAmount = val ;
            // }
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  _selectedDate == null
                      ? "No Date Chosen !!"
                      : ' pickedDate :${DateFormat.yMd().format(_selectedDate)}',
                ),
              ),
              FlatButton(
                textColor: Colors.purple,
                onPressed: _presentDatePicker,
                child: Text("Choose Date"),
                hoverColor: Colors.blue[100],
              )
            ],
          ),
          SizedBox(
            height: 50,
          ),
          RaisedButton(
            hoverElevation: 10,
            hoverColor: Colors.cyan[300],
            color: Colors.amber[50],
            textColor: Colors.purple,
            onPressed: submitData,
            child: Text("Add Transaction"),
          ),
        ],
      ),
    ));
  }
}
